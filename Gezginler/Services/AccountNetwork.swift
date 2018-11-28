
import UIKit
import Firebase
import ObjectMapper

class AccountNetwork{
  
    
    let databaseRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    init() {
    }
    
     func register(model:  CreateUserModel, completion: @escaping (BaseModel) -> ()){
    
 
        
        
        Auth.auth().createUser(withEmail: model.email!, password: model.password!) { (user, error) in
           
            if (error != nil )
            {
                let returnModel  = BaseModel()
                returnModel.error  =  error?.localizedDescription
                returnModel.isOk = false
                completion(returnModel)
            } else {
                
                model.userId  =  user?.uid
                self.registerDetails(model: model, completion: completion)
            }            
            
        }
        
    }
    
      func registerDetails(model:  CreateUserModel, completion: @escaping (BaseModel) -> ()){
        
        let returnModel  = BaseModel()
        
        let userModel  =  UserModel()
        userModel.userId = model.userId!
        userModel.userName = model.userName!
        userModel.imageUrl = ""
     
        
        let userReference = databaseRef.child("userinfo")
            .child(model.userId!)
            .child("credentials")
        
        let json = userModel.toJSON()
    
        
        userReference.setValue(json) { (error, db) in
            returnModel.isOk = true
            completion(returnModel)
        }
        
        }
    
    
      func login(model:  CreateUserModel, completion: @escaping (BaseModel) -> ())
      {
         let returnModel  = BaseModel()
        Auth.auth().signIn(withEmail: model.email!, password: model.password!) { (user, error) in
            
            if error != nil{
                returnModel.error = error?.localizedDescription
                returnModel.isOk = false
                completion(returnModel)
            }
            
            returnModel.isOk = true
            completion(returnModel)
            
        }
    }
    
    func getUser(completion: @escaping (UserModel) -> ()){
        
        let user = Auth.auth().currentUser
        
        let userId  = (user?.uid)!
        let userReference = self.databaseRef
            .child("userinfo")
            .child(userId)
            .child("credentials")
        
        userReference
            .observe(.value) { (snapshot: DataSnapshot) in
                let json = snapshot.value as! [String : Any]
                let  userDetail = Mapper<UserModel>().map(JSON: json)
                completion(userDetail!)
        }
        
    }
    
    func getUser(userId:String, completion: @escaping (UserModel) -> ()){
        
        let userReference = self.databaseRef
            .child("userinfo")
            .child(userId)
            .child("credentials")
        
        userReference
            .observe(.value) { (snapshot: DataSnapshot) in
                let json = snapshot.value as! [String : Any]
                let  userDetail = Mapper<UserModel>().map(JSON: json)
                completion(userDetail!)
        }
        
    }
    
    func updateDetail(userModel: UserModel, completion: @escaping (BaseModel) -> ()){
        
        let returnModel  = BaseModel()
        let userReference = databaseRef.child("userinfo")
                .child((Auth.auth().currentUser?.uid)!)
                .child("credentials")
            
 
            
            let json = userModel.toJSON()
            
            userReference.updateChildValues(json, withCompletionBlock: { (error, ref) in
                    if error != nil{
                        returnModel.error = error?.localizedDescription
                        returnModel.isOk = false
                        completion(returnModel)
                    }
                    
                    returnModel.isOk = true
                    completion(returnModel)
                    
            })
    }
    

    
}
