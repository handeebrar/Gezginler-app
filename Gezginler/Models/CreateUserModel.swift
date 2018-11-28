
import UIKit

public final class CreateUserModel {
    
   
    public var userId : String?
    public var email : String?
    public var password : String?
    public var confirmPassword : String?
    public var name : String?
    public var userName : String?
    
    public init(_email: String,_password: String,_confirmPassword: String,_name: String)
    {
        self.confirmPassword = _confirmPassword
        self.email = _email
        self.password = _password
        self.name  =  _name
    }
    public init(){ //constructor
        
    }
    
}




