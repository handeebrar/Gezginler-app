
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

import TableKit


class feedVC: UIViewController  {
    
     var posts = [UserPost]()
    
    var tableDirector: TableDirector!
    
    @IBOutlet var tableView: UITableView!{
        didSet {
            tableDirector = TableDirector(tableView: tableView, shouldUsePrototypeCellHeightCalculation: true)
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // tab bardab buraya tekrardan gelince çalışır
    override func viewDidAppear(_ animated: Bool) {
         refreshData()
    }
    
    func refreshData() {
        
        posts = [UserPost]()
        // birinci sorgu
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            let post = values["post"] as! NSDictionary
            let postIDs = post.allKeys
            let count  = post.allKeys.count
            
            var index  = 0
            
            for id in postIDs {
                let singlePost = post[id] as! NSDictionary
                let userId  = singlePost["uuid"] as! String
                
                let postModel  =  UserPost()
                postModel.uuid  = userId
                postModel.posttext = singlePost["posttext"] as! String
                postModel.image = singlePost["image"] as! String
                
                // ikinci sorgu
                AccountNetwork().getUser(userId: userId, completion: { (user) in
                    postModel.userModel = user
                  
                    // her zaman index 0 ksımına at
                    self.posts.insert(postModel, at: 0)
                    index  =  index + 1
                    
                    if (index ==  count)
                    {
                        self.tableviewBind()
                    }
                })
                
                
               
            }
            

            
        }
        
    }
    
    func tableviewBind(){
        
        tableDirector.clear()
        
        let section = TableSection(headerView: nil, footerView: nil)
        
        var rows = 0
        while rows < posts.count {
            let model =  posts[rows]
            
            let setModel  = FeedModel()
            setModel.model =  model
            setModel.parentView = self
            
            
            let row = TableRow<feedCellTableViewCell>(item: setModel) // yeni row oluştur
           
            section += row
            rows += 1
            
        }
        
        tableDirector += section // row ları table e ata
        
        tableDirector.reload() // tabloyu yeniden yükle
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
   
        
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }catch let err {
            print(err)
        }
    }
    
}

