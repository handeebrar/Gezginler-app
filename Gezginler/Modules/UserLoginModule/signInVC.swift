
import UIKit
import Firebase
import FirebaseAuth

class signInVC: BaseViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        hideKeyboardWhenTappedAround()
        
        
    }


    @IBAction func signUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "toSignup", sender: nil)
 
    }
    
    @IBAction func signInClicked(_ sender: Any) {
        
        
         if (emailText.text == "" || passwordText.text == "")
         {
            showError("Alanlar boş geçilemez")
            return
         }        
        
        let model  = CreateUserModel()
        
        model.email = emailText.text!
        model.password =  passwordText.text!
        
        AccountNetwork().login(model: model) { (response) in
            
            if (response.error != nil)
            {
                
                self.showError(response.error)
                return
                
            }
            
             self.performSegue(withIdentifier: "toTabBar", sender: nil)
            
        }
 
    }
    
}
