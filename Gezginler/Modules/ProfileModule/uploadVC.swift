
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class uploadVC: BaseViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageViev: UIImageView!
    @IBOutlet weak var textViev: UITextView!
    var uuid = NSUUID().uuidString
        
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViev.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(uploadVC.choosePhoto))
        imageViev.addGestureRecognizer(recognizer)
     
        imageViev.image =  UIImage(named: "photo.png")
     
    }
    
    @IBAction func postClicked(_ sender: Any) {
     
        let mediaFolder = Storage.storage().reference().child("media")
        
        if let data = UIImageJPEGRepresentation(imageViev.image!, 0.5) {
            
            if(imageViev.image ==  UIImage(named: "photo.png"))
            {
                self.showError("Resim seçiniz")

                return
            }
            
            
            mediaFolder.child("\(uuid).jpg").putData(data, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                
                    self.showError(error?.localizedDescription)
                    
                } else {
               
                    let userId  =  Auth.auth().currentUser?.uid
                    
                    let imageURL = metadata?.downloadURL()?.absoluteString
                  
                    
                    let post = ["image" : imageURL!, "postedby" : Auth.auth().currentUser!.email!, "uuid" : userId as Any, "posttext" : self.textViev.text] as [String : Any]
                    
                    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("post").childByAutoId().setValue(post)
                    self.imageViev.image = UIImage(named: "photo.png")
                    self.textViev.text = ""
                    self.tabBarController?.selectedIndex = 0
                    
                    
                }
                
            })
            
        }
            

    }
    
    
    @objc func choosePhoto() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageViev.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
 

}
