

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class signUpVC: BaseViewController{

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
  
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        let model  =  CreateUserModel()
        
        model.email = emailText.text
        model.password =  passwordText.text
        model.userName = usernameText.text
        
    
        AccountNetwork().register(model: model) { (returnModel) in
            
            if (returnModel.isOk == true)
            {
                self.showMessage("Kayıt Başarılı, Login sayfasından giriş yapınız", withTitle: "")
                
            } else {
               
                self.showError(returnModel.error)
            }
        }
        
    }
  

    @IBAction func dismiss(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
