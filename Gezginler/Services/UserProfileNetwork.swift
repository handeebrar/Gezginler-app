
import UIKit
import Firebase
import ObjectMapper

class UserProfileNetwork {
    let databaseRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    init() {
    }
    
    
    func userUpdate(imageData: Data,username:String,about:String ,completion: @escaping (UserModel) -> ()){
        
        let user = Auth.auth().currentUser
        let userId  = (user?.uid)!
        
            let mediafolder = Storage.storage().reference().child("avatar")
            
                mediafolder.child("\(userId).jpg").putData(imageData, metadata: nil, completion: { (metadata, error) in
                    if error == nil{
                        let imageUrl = metadata?.downloadURL()?.absoluteString
                        
                      AccountNetwork().getUser(completion: { (userModel) in
                            
                            userModel.imageUrl = imageUrl!
                            userModel.userName = username
                            userModel.about = about
                            
                            
                            AccountNetwork().updateDetail(userModel: userModel, completion: { (response) in
                                
                                completion(userModel)
                            })
                        })
                        
                        
                        
                    }else{
                        print("resim yüklenemedi ve diğer işlemler olmadı")
                    }
                })
         
       
    }

    
    
    
}
