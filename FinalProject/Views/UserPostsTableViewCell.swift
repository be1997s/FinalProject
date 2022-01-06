//
//  UserPostsTableViewCell.swift
//  FinalProject
//
//  Created by BE X on 02/06/1443 AH.
//

import UIKit
import CleanyModal
class UserPostsTableViewCell: UITableViewCell {
    var post : Post?
    var PostTagsArray : [String] = []
    @IBOutlet weak var Ownerpic: UIImageView!
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var delOutlet: UIButton!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var SavedOutlet: UIButton!
    @IBOutlet weak var PostImg: UIImageView!
    @IBOutlet weak var tagsCV: UICollectionView!   {     didSet{
        tagsCV.delegate = self
        tagsCV.dataSource = self
    }}
    @IBOutlet weak var likesNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deletePost(_ sender: Any) {
     
        NotificationCenter.default.post(name: NSNotification.Name("deletePost"), object: nil, userInfo:["cell":self])
     
    }
    
}
extension UserPostsTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostTagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCell
        var tagName = PostTagsArray[indexPath.row]
        cell.tagName.text = tagName
        cell.view = ViewStyle.ViewcornerRadius(view: cell.view)
        cell.view.backgroundColor = .random()
        cell.tagName = ViewStyle.ViewShadow(view: cell.tagName) as? UILabel
        
        return cell
    }

    
    
}


