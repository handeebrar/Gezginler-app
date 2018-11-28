
import UIKit
import ObjectMapper

class UserPost: Mappable {

    public var postedby : String = ""
    public var posttext : String = ""
    public var image : String = ""
    public var uuid : String = ""
    
    public var userModel  : UserModel! // detay tablosu
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        postedby    <- map["postedby"]
        posttext         <- map["posttext"]
        image      <- map["image"]
        uuid      <- map["uuid"]
       
    }
}
