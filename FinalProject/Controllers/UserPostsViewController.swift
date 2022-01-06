//
//  UserPostsViewController.swift
//  FinalProject
//
//  Created by BE X on 02/06/1443 AH.
//

import UIKit
import SPIndicator
class UserPostsViewController: UIViewController {
    var PostsArray : [Post] = []
    
    @IBOutlet weak var PostTableview: UITableView!
    override func viewDidLoad() {
        PostTableview.delegate = self
        PostTableview.dataSource = self
 
        PostApi.gatPostbyUser(id: UserManager.LoggedInUser!.id) { arr in
            self.PostsArray = arr
            self.PostTableview.reloadData()
        }
        NotificationCenter.default.addObserver( self, selector: #selector(deletePost), name : NSNotification.Name(rawValue: "deletePost"), object: nil)
                super.viewDidLoad()


    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deletePost(notification : Notification){

    if let cell = notification.userInfo?["cell"] as? UITableViewCell {
        if let index = self.PostTableview.indexPath(for: cell){
            let post = self.PostsArray[index.row]
        PostApi.deletePost(id: post.id) { message in
                    if message != nil {
                        let alert = MyAlertViewController(
                            title: "Error",
                            message: message,
                            imageName: "exclamation")
                        alert.addAction(title: "OK", style: .default)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        SPIndicator.present(title: "Sucsess", message: "Post deleted!", preset: .done ,completion: {
                            PostApi.gatPostbyUser(id: UserManager.LoggedInUser!.id) { arr in
                                self.PostsArray = arr
                                self.PostTableview.reloadData()
                                NotificationCenter.default.post(name: NSNotification.Name("updatedata"), object: nil)
                                
                            }
                        }
                        ) }
        }
                  
         
        }
        }
    }
}
    


extension UserPostsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "UserPostsTableViewCell") as! UserPostsTableViewCell
        cell.postText.text = PostsArray[indexPath.row].text
        if PostsArray[indexPath.row].image != "" {
            cell.PostImg.image = imageUrl.imageRELOAD(imageURL: PostsArray[indexPath.row].image!)
        } else {
            cell.PostImg.isHidden = true
        }
        // user data
        cell.OwnerName.text = PostsArray[indexPath.row].owner.firstName + " " + PostsArray[indexPath.row].owner.lastName
         if  (PostsArray[indexPath.row].owner.picture) != nil {
            cell.Ownerpic.image = imageUrl.imageRELOAD(imageURL: (PostsArray[indexPath.row].owner.picture)!
            )}
        
        cell.Ownerpic = ViewStyle.ViewCircler(view: cell.Ownerpic) as! UIImageView
        
        cell.PostImg = ViewStyle.ViewcornerRadius(view: cell.PostImg) as! UIImageView
        
        cell.likesNumber.text = "\(PostsArray[indexPath.row].likes!)"
      
        if PostsArray[indexPath.row].tags != nil {
            cell.tagsCV.isHidden = false
        cell.PostTagsArray = PostsArray[indexPath.row].tags!
        } else {cell.tagsCV.isHidden = true}
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
        cell.delOutlet = ViewStyle.ViewcornerRadius(view: cell.delOutlet) as! UIButton
        cell.mainview = ViewStyle.ViewShadow(view: cell.mainview)
        cell.mainview = ViewStyle.ViewcornerRadius(view: cell.mainview)
        
        
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

