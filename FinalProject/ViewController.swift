//
//  ViewController.swift
//  FinalProject
//
//  Created by BE X on 11/05/1443 AH.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    var PostsArray : [Post] = []
    
    @IBOutlet weak var PostTableView: UITableView!
    override func viewDidLoad() {
        PostTableView.delegate = self
        PostTableView.dataSource = self
        let Url = "https://dummyapi.io/data/v1/post"
        let Appid = "61b9f8c255884d63efef801d"
        let header : HTTPHeaders = ["app-id" : Appid]
        AF.request(Url , headers: header).responseJSON { (res) in
            let jsonData = JSON(res.value)
            let data = jsonData["data"]
            let decoder = JSONDecoder()
            do{
                 self.PostsArray = try decoder.decode([Post].self,from : data.rawData())
                self.PostTableView.reloadData()
            }   catch {    print("error in rawdata") }
            
        }
        super.viewDidLoad()
    }


}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        cell.postText.text = PostsArray[indexPath.row].text
        
        // Logic for image view
        let url = URL(string: PostsArray[indexPath.row].image)!
        if let data = try? Data(contentsOf: url) {
               // Create Image and Update Image View
            cell.PostImage.image = UIImage(data: data)
           }
        
        // user data
        cell.OwnerName.text = PostsArray[indexPath.row].owner.firstName + " " + PostsArray[indexPath.row].owner.lastName
        let url1 = URL(string: PostsArray[indexPath.row].owner.picture)!
        if let data1 = try? Data(contentsOf: url1) {
               // Create Image and Update Image View
            cell.OwnerImage.image = UIImage(data: data1)
           }
        cell.OwnerImage.layer.cornerRadius = cell.OwnerImage.frame.size.width/2

        cell.PostImage.layer.cornerRadius = 10
        cell.likesNumber.text = "\(PostsArray[indexPath.row].likes)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 405
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = PostsArray[indexPath.row]
        let vc =  storyboard?.instantiateViewController(identifier: "PostVC") as! PostVC
        vc.post = selectedPost
        
        present(vc, animated: true, completion:nil)
    }
    
  
}

