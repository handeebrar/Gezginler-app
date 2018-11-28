
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class editVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var aboutText: UITextView!
    
    let ref = Database.database().reference()
    let uuid = NSUUID().uuidString
     let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePicture.image = UIImage(named: "profile.png")
        profilePicture.isUserInteractionEnabled  = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(editVC.choosePhoto))
        profilePicture.addGestureRecognizer(recognizer)
        
    
    }
    
    @objc func choosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        let alert = UIAlertController(title: "Fotoğraf Ekle", message: "Seç", preferredStyle: UIAlertControllerStyle.actionSheet)
        
    
        let photoLibrary = UIAlertAction(title: "Galeri", style: UIAlertActionStyle.default) { (action) in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "İptal", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(photoLibrary)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profilePicture.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
   

    @IBAction func updateClicked(_ sender: Any) {
        let user = Auth.auth().currentUser
        let keys = self.ref.child("userinfo").child((user?.uid)!).child("credentials")
        
        print(keys)
    
        if self.profilePicture.image != UIImage(named: "profile.png")
        {
            if (userNameText.text != ""){
            let data = UIImageJPEGRepresentation(self.profilePicture.image!, 0.5)
            UserProfileNetwork().userUpdate(imageData: data!,username: userNameText.text!,about: aboutText.text!, completion: { (userModel) in
                let alert = UIAlertController(title: "Güncellendi!", message: "Bilgiler başarıyla güncellendi!", preferredStyle: UIAlertControllerStyle.actionSheet)
                let ok = UIAlertAction(title: "Tamam", style:UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            })
            }else{
                let alert = UIAlertController(title: "Kullanıcı adı", message:"Kullanıcı adı kısmı boş geçilemez!", preferredStyle: UIAlertControllerStyle.actionSheet)
                let ok = UIAlertAction(title: "Tamam", style:UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
           
        }else{
            if self.userNameText.text == "" {
            /*    keys.child("userName").observe(.value, with: { (usernameSnapshot) in
                    keys.updateChildValues(["userName" : self.userNameText.text as Any])
                    print("username güncellendi")
                })
                */
                keys.child("about").observe(.value, with: { (aboutSnapshot) in
                    keys.updateChildValues(["about" : self.aboutText.text as Any])
                    print("hakkında güncellendi")
                })
                
            }else{
                print("kullanıcı adı değiştirilmedi")
            }
          
            
        }
            

        
    }
    

}
