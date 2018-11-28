
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImage
import Lightbox


class profileVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var aboutText: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var editBtn: UIButton!
    
    @IBOutlet var postBtn: UIButton!
    
    let databaseRef = Database.database().reference()
    
    let user = Auth.auth().currentUser
    
    
    var userId = ""
    
    var photoUrlArray = [String]()
    
   var posts = [UserPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
         userImage.image = UIImage(named: "profile.png")
         
       
        if (userId == "")
        {
            // local kullanıcı
            userId = (user?.uid)!
       
        } else {
            editBtn.isHidden = true
            postBtn.isHidden = true
        }
        
        AccountNetwork().getUser(userId: userId) { (user) in
            self.userImage.sd_setImage(with: URL(string: (user.imageUrl)), completed: nil)
            self.userNameText.text = user.userName
            self.aboutText.text = user.about
            
        
        }
     
        
        refreshData()

    }

    
    func refreshData() {
        
        
        // birinci sorgu
        Database.database().reference().child("users")
        .child(userId)
        .observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            let post = values.allKeys
            
             var index  = 0
             let count  = values.allKeys.count
            for id in post {
                let singlePost = values[id] as! NSDictionary
                
                 let postModel  =  UserPost()
                 postModel.uuid  = singlePost["uuid"] as! String
                 postModel.posttext = singlePost["posttext"] as! String
                postModel.image = singlePost["image"] as! String
                
                
                                // ikinci sorgu
                AccountNetwork().getUser(userId: postModel.uuid  , completion: { (user) in
                    postModel.userModel = user
                  
                    self.posts.insert(postModel, at: 0)
                    index  =  index + 1
                    if (index ==  count)
                    {

                        self.collectionView.reloadData()
                    }
                })
            }
 
            
        }
        
    }
    

    @IBAction func editButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toEdit", sender: nil)
        
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toUpload", sender: nil)
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellP", for: indexPath) as! profileCollectionViewCell
        
        let item  =  posts[indexPath.row]
        
        cell.imageView.sd_setImage(with: URL(string: item.image))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item  =  posts[indexPath.row]
        let images = [
            LightboxImage(imageURL: URL(string: item.image)!)
        ]
        let controller = LightboxController(images: images)
        controller.dynamicBackground = true
        controller.title =  ""
        
        present(controller, animated: true, completion: nil)
    }
 


}
