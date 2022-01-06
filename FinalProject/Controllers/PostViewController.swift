//
//  PostVC.swift
//  FinalProject
//
//  Created by BE X on 12/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView
import SPIndicator
class PostViewController: UIViewController {
    var CommentsArray : [Comments] = []
    var post : Post!

    @IBOutlet weak var CommentsView: UIView!
    
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var ActivityLoader: NVActivityIndicatorView!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var OwnerPic: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var Text: UILabel!
    @IBOutlet weak var SendOutlet: UIButton!
    
    var noPlacesMessageLabel: UILabel {
        let label = UILabel(frame: CommentsTableView.bounds)
        label.text = "No comments here.."
        label.font = CommentLabel.font
        label.textColor = UIColor(ciColor: .gray)
        label.textAlignment = .center
        return label
    }

    override func viewDidLoad() {
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        
        CommentsView = ViewStyle.ViewShadow(view: CommentsView)
        CommentsView = ViewStyle.ViewcornerRadius(view: CommentsView)
        SendOutlet = ViewStyle.ViewcornerRadius(view: SendOutlet) as! UIButton
        
        OwnerName.text = post.owner.firstName + " " + post.owner.lastName
        Text.text = post.text
        
        OwnerPic = ViewStyle.ViewCircler(view: OwnerPic) as! UIImageView
        PostImage = ViewStyle.ViewcornerRadius(view: PostImage) as! UIImageView
        backbutton = ViewStyle.ViewcornerRadius(view: backbutton) as! UIButton
       
        CommentLabel = ViewStyle.ViewcornerRadius(view: CommentLabel) as! UILabel
        if  post.image != "" {
            PostImage.image = imageUrl.imageRELOAD(imageURL: post.image!)}
        else {
            PostImage.isHidden = true
        }
        
        if  post.owner.picture != "" {
            OwnerPic.image = imageUrl.imageRELOAD(imageURL: post.owner.picture!)
        }
            //get comments
        self.reloaddata()
        if UserManager.LoggedInUser == nil {
            commentText.isHidden = true
            SendOutlet.isHidden = true

        }

        super.viewDidLoad()
        
     
        

}
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Send(_ sender: Any) {
        if UserManager.LoggedInUser != nil {
            PostApi.addComment(id: (UserManager.LoggedInUser?.id)! , Postid: post.id, messege: commentText.text!, completionhandler:{
                SPIndicator.present(title: "Sucsess", message: nil, preset: .done ,completion: {
                    self.reloaddata()
                    self.commentText.text = ""
                })
                
            })
            }
    }

    
    func reloaddata() {
        ActivityLoader.startAnimating()
        CommentsTableView.isHidden = true
        PostApi.gatComment(id: post.id,completionhandler: {
            arr in
            self.CommentsArray = arr
            self.CommentsTableView.reloadData()
            self.CommentsTableView.isHidden = false
            self.ActivityLoader.stopAnimating()
            if self.CommentsArray.count > 1
                            {self.CommentLabel.text = "\(self.CommentsArray.count) Comments"}
        else {
            self.CommentLabel.text = "\(self.CommentsArray.count) Comment"
            }
            
            if self.CommentsArray.count == 0{
                self.CommentsTableView.backgroundView = UIView(frame: self.CommentsTableView.bounds)
                self.CommentsTableView.backgroundView?.addSubview(self.noPlacesMessageLabel)
                self.CommentsTableView.separatorStyle = .none
            }
        }
        
        )}
}


extension PostViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return CommentsArray.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCellTableViewCell
        cell.commentLabel.text = CommentsArray[indexPath.row].message
        
        // user data
        cell.OwnerName.text = CommentsArray[indexPath.row].owner.firstName + " " + CommentsArray[indexPath.row].owner.lastName
        if CommentsArray[indexPath.row].owner.picture != "" {
        cell.OwnerPic.image = imageUrl.imageRELOAD(imageURL: CommentsArray[indexPath.row].owner.picture!)
        }
        cell.OwnerPic = ViewStyle.ViewCircler(view: cell.OwnerPic) as! UIImageView
        return cell
    }
    

    
}
