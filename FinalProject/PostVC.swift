//
//  PostVC.swift
//  FinalProject
//
//  Created by BE X on 12/05/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
class PostVC: UIViewController {
    var CommentsArray : [Comments] = []
    var post : Post!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var OwnerPic: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var Text: UILabel!
    override func viewDidLoad() {
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        OwnerName.text = post.owner.firstName + " " + post.owner.lastName
        Text.text = post.text
        // Logic for image view
        
        OwnerPic.layer.cornerRadius = OwnerPic.bounds.height/2
        PostImage.layer.cornerRadius = 10
        backbutton.layer.cornerRadius = 10
        CommentLabel.layer.cornerRadius = 5

        let url = URL(string: post.image)!
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            PostImage.image = UIImage(data: data)
           }
        let url1 = URL(string: post.owner.picture)!
        if let data1 = try? Data(contentsOf: url1) {
               // Create Image and Update Image View
            OwnerPic.image = UIImage(data: data1)
           }
        let urll = "https://dummyapi.io/data/v1/post/\(post.id)/comment"
        let Appid = "61b9f8c255884d63efef801d"
        let header : HTTPHeaders = ["app-id" : Appid]
        AF.request(urll , headers: header).responseJSON { (res) in
            let jsonData = JSON(res.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                      self.CommentsArray = try decoder.decode([Comments].self,from : data.rawData())
                self.CommentsTableView.reloadData()
            }   catch {    print("error in rawdata") }
            
        }
        super.viewDidLoad()
        
       

}
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension PostVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCellTableViewCell
        cell.commentLabel.text = CommentsArray[indexPath.row].message
        
        // user data
        cell.OwnerName.text = CommentsArray[indexPath.row].owner.firstName + " " + CommentsArray[indexPath.row].owner.lastName
        let url1 = URL(string: CommentsArray[indexPath.row].owner.picture)!
        if let data1 = try? Data(contentsOf: url1) {
               // Create Image and Update Image View
            cell.OwnerPic.image = UIImage(data: data1)
           }
        cell.OwnerPic.layer.cornerRadius = cell.OwnerPic.frame.size.width/2

        return cell
    }
    
    
}
