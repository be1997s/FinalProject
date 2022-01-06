//
//  ViewController.swift
//  FinalProject
//
//  Created by BE X on 11/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView
import Firebase
class HomeViewController: UIViewController {
    let db = Firestore.firestore()
    var PostsArray : [Post] = []
    var tag : String?
    var PostTagsArray : [String] = []
    var page = 0
    var total = 0
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var BackIcon: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var UserPic: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: NVActivityIndicatorView!
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var PostTableView: UITableView!
   
    
    override func viewDidLoad() {

        if tag == nil {
            firstLabel.text = "Welcome"
            BackIcon.isHidden = true
        } else {
            firstLabel.text = "#\(tag!) Posts"
            NameLabel.isHidden = true
            UserPic.isHidden = true
            BackIcon = ViewStyle.ViewcornerRadius(view: BackIcon) as? UIButton
        }
        
        if UserManager.LoggedInUser == nil {
            NameLabel.isHidden = true
            UserPic.isHidden = true
        } else {
            NameLabel.text = UserManager.LoggedInUser?.firstName
            if  UserManager.LoggedInUser?.picture != "" {
                UserPic.image = imageUrl.imageRELOAD(imageURL:(UserManager.LoggedInUser?.picture!)!)}
            UserPic = ViewStyle.ViewCircler(view: UserPic) as? UIImageView
            UserPic = ViewStyle.Viewborder(view: UserPic) as? UIImageView
        }
        
     
        PostTableView.delegate = self
        PostTableView.dataSource = self
        NotificationCenter.default.addObserver( self, selector: #selector(UserProfile), name : NSNotification.Name(rawValue: "userSVTapped"), object: nil)
        
        NotificationCenter.default.addObserver( self, selector: #selector(getPost), name : NSNotification.Name(rawValue: "updatedata"), object: nil)
        NotificationCenter.default.addObserver( self, selector: #selector(MoveToComments), name : NSNotification.Name(rawValue: "ToCommentsPage"), object: nil)
        
        NotificationCenter.default.addObserver( self, selector: #selector(SavePost), name : NSNotification.Name(rawValue: "SavePost"), object: nil)
        refreshControl.tintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        refreshControl.addTarget(self, action:  #selector(refreshPosts), for: .valueChanged)
        PostTableView.addSubview(refreshControl)
    //get Post from Api
         getPost()

        super.viewDidLoad()
       

    }
    @objc func MoveToComments(notification : Notification){
   
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let index = PostTableView.indexPath(for: cell){
            let post = PostsArray[index.row]
                
                let vc = storyboard?.instantiateViewController(identifier: "PostVC") as! PostViewController
                
                vc.post = post
                present(vc, animated: true, completion: nil)
                
                
                
                
            }

        }
    }
    
    @objc func SavePost(notification : Notification){
        if UserManager.LoggedInUser != nil {

        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let index = PostTableView.indexPath(for: cell){
            let post1 = PostsArray[index.row]
                firebase.saveData(postid : post1.id )
            }
        }
            
        self.PostTableView.reloadData()
    }
    }
     
            

    
    @objc func getPost() {
        self.activityIndicatorView.startAnimating()
        PostApi.gatPosts (page: page,tag: tag, completionhandler: {
            postResponse , t in
            self.total = t
            self.PostsArray.append(contentsOf: postResponse)
            self.PostTableView.reloadData()
            self.activityIndicatorView.stopAnimating()

            
        })
    }
    @objc func refreshPosts() {
        PostApi.gatPosts (page: 0,tag: tag, completionhandler: {
            postResponse , t in
            self.total = t
            self.PostsArray = postResponse
            self.PostTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // Mark : Action
    @objc func UserProfile(notification : Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let index = PostTableView.indexPath(for: cell){
            let post = PostsArray[index.row]
                
                let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! accountProfileVC
                
                vc.user = post.owner
                present(vc, animated: true, completion: nil)
                
                
                
                
            }
    
        
        }
        
    }
    
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var saved : [String] = []
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.postText.text = PostsArray[indexPath.row].text
        if PostsArray[indexPath.row].image != "" {
        cell.PostImage.image = imageUrl.imageRELOAD(imageURL: PostsArray[indexPath.row].image!)
        } else {
            cell.PostImage.isHidden = true
        }
        // user data
        cell.OwnerName.text = PostsArray[indexPath.row].owner.firstName + " " + PostsArray[indexPath.row].owner.lastName
         if  (PostsArray[indexPath.row].owner.picture) != "" {
            cell.OwnerImage.image = imageUrl.imageRELOAD(imageURL: (PostsArray[indexPath.row].owner.picture)!
            )}
        
        cell.OwnerImage = ViewStyle.ViewCircler(view: cell.OwnerImage) as! UIImageView
        
        cell.PostImage = ViewStyle.ViewcornerRadius(view: cell.PostImage) as! UIImageView
        
        cell.likesNumber.text = "\(PostsArray[indexPath.row].likes!)"
        
        
        cell.MainView = ViewStyle.ViewcornerRadius(view: cell.MainView)
        cell.MainView = ViewStyle.ViewShadow(view: cell.MainView)
        if PostsArray[indexPath.row].tags != nil {
        cell.PostTagsCV.isHidden = false
        cell.PostTagsArray = PostsArray[indexPath.row].tags!
        } else {cell.PostTagsCV.isHidden = true}
        cell.post = PostsArray[indexPath.row]
        
        
        if UserManager.LoggedInUser != nil {
            let userid = UserManager.LoggedInUser!.id
       db.collection("SavePosts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.get("UserId") as! String == userid && (document.get("PostId") as! [String]).contains(self.PostsArray[indexPath.row].id) {
                        saved = document["PostId"] as! [String]
                        cell.SaveOutlet.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
                                break }
                    else {cell.SaveOutlet.setImage(UIImage.init(systemName: "bookmark"), for: .normal)}
        }
            }
       }  }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = PostsArray[indexPath.row]
        let vc =  storyboard?.instantiateViewController(identifier: "PostVC") as! PostViewController
        vc.post = selectedPost
        present(vc, animated: true, completion:nil)
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (PostsArray.count - 1) && PostsArray.count < total {
            page = page + 1
            //get Post from Api
            self.activityIndicatorView.startAnimating()
            getPost()
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    
    
  
}

