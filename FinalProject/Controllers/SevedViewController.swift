//
//  SearchViewController.swift
//  FinalProject
//
//  Created by BE X on 20/05/1443 AH.
//

import UIKit
import Firebase
import NVActivityIndicatorView
class SevedViewController: UIViewController {
    static let db1 = Firestore.firestore()
    var PostsArray : [Post] = []
    var tag : String?
    var PostTagsArray : [String] = []
    var list : [String] = []
    var page = 0
    var total = 0
    @IBOutlet weak var SavedtableView: UITableView!

    @IBOutlet weak var loader: NVActivityIndicatorView!
    override func viewDidLoad() {
        SavedtableView.delegate = self
        SavedtableView.dataSource = self
           NotificationCenter.default.addObserver( self, selector: #selector(UserProfile), name : NSNotification.Name(rawValue: "userSVTapped"), object: nil)
           
           NotificationCenter.default.addObserver( self, selector: #selector(MoveToComments), name : NSNotification.Name(rawValue: "ToCommentsPage"), object: nil)
           
           NotificationCenter.default.addObserver( self, selector: #selector(SavePost), name : NSNotification.Name(rawValue: "SavePost"), object: nil)
                 getPost()
        
                super.viewDidLoad()


    }
    
 
   
    @objc func MoveToComments(notification : Notification){
   
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let index = SavedtableView.indexPath(for: cell){
            let post = PostsArray[index.row]
                let vc = storyboard?.instantiateViewController(identifier: "PostVC") as! PostViewController
                vc.post = post
                present(vc, animated: true, completion: nil)

            }

        }
    }

    
    @objc func SavePost(notification : Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let index = SavedtableView.indexPath(for: cell){
            let post1 = PostsArray[index.row]
                firebase.saveData(postid : post1.id )
                getPost()
            }
        }
    }
    
    func getPost() {
        
        self.loader.startAnimating()
         firebase.db.collection("SavePosts").getDocuments(){(querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {

                    for document in querySnapshot!.documents {
                        if document.get("UserId") as! String == UserManager.LoggedInUser?.id {
                            if let listt = document["PostId"]{
                                self.list = listt as! [String]
                                self.PostsArray = []
                                for i in self.list {
                                PostApi.gatPost(id: i) { p in
                                    self.PostsArray.append(p)
                                   self.SavedtableView.reloadData()

                                }}
                                break
                            }
                            
                                    }
                            }
                }
         }
        self.loader.stopAnimating()

    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // Mark : Action
    @objc func UserProfile(notification : Notification){
        if let cell = notification.userInfo?["cell"] as? UITableViewCell {
            if let index = SavedtableView.indexPath(for: cell){
            let post = PostsArray[index.row]
                
                let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! accountProfileVC
                
                vc.user = post.owner
                present(vc, animated: true, completion: nil)
                
            }
    
        
        }
        
    }
    
}
extension SevedViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SavedTableViewCell") as! SavedTableViewCell
        cell.PostText.text = PostsArray[indexPath.row].text
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
        
        cell.numberOfLikes.text = "\(PostsArray[indexPath.row].likes!)"
        cell.MainView = ViewStyle.ViewcornerRadius(view: cell.MainView)
        cell.MainView = ViewStyle.ViewShadow(view: cell.MainView)
        if PostsArray[indexPath.row].tags != nil {
        cell.PostTagsCV.isHidden = false
        cell.PostTagsArray = PostsArray[indexPath.row].tags!
        } else {cell.PostTagsCV.isHidden = true}
        cell.post = PostsArray[indexPath.row]
        
        
        
        let userid = UserManager.LoggedInUser!.id
        SevedViewController.db1.collection("SavePosts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.get("UserId") as! String == userid && (document.get("PostId") as! [String]).contains(self.PostsArray[indexPath.row].id) {
                        cell.SavedOutlet.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
                                break }
                    else {cell.SavedOutlet.setImage(UIImage.init(systemName: "bookmark"), for: .normal)}
        }
            }
            }
        
        cell.MainView  = ViewStyle.ViewcornerRadius(view:   cell.MainView )
        cell.MainView  = ViewStyle.ViewShadow(view:   cell.MainView)
        
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
   
    
}


