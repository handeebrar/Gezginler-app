
import UIKit
import ObjectMapper

class UserModel :Mappable{
   
    required init?(map: Map) {
        
    }
    
    
    public var userId : String = ""
    public var userName : String = ""
    public var email : String = ""
    public var password : String = ""
    public var about: String = ""
    public var name : String = ""
    public var imageUrl : String = ""
    public var imageData : Data?  =  nil
    
    
    init() {
        
    }

    // Mappable
    func mapping(map: Map) {
        userId    <- map["userId"]
        userName         <- map["userName"]
        email      <- map["email"]
        password       <- map["password"]
        about  <- map["about"]
        name  <- map["name"]
        imageUrl     <- map["imageUrl"]
    }
}
