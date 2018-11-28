
import TableKit

class feedCellTableViewCell: UITableViewCell ,ConfigurableCell{
   
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet var postText: UILabel!
    
    var parent :  UIViewController?
    
    var  model: FeedModel!
    
    func configure(with  model: FeedModel) {
        
        self.parent =  model.parentView
        
        self.model = model
        
        bind(model: model)
    }

    
    func bind(model: FeedModel){
        
        userImage.sd_setImage(with: URL(string: model.model.userModel.imageUrl))
        postImage.sd_setImage(with: URL(string: model.model.image))
        userNameLabel.text = model.model.userModel.userName
        postText.text = model.model.posttext
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(feedCellTableViewCell.tapFunction))
        userNameLabel.isUserInteractionEnabled = true
        userNameLabel.addGestureRecognizer(tap)
        
    
    }
    
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        
        let userProfile  =  parent?.storyboard?.instantiateViewController(withIdentifier: "profileVC") as! profileVC
        
        userProfile.userId = self.model.model.userModel.userId
        
        parent?.navigationController?.pushViewController(userProfile, animated: true)
    }
  

   

}
