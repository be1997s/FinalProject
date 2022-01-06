//
//  PostCell.swift
//  FinalProject
//
//  Created by BE X on 11/05/1443 AH.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    let db = Firestore.firestore()
    var PostTagsArray : [String] = []
    var post : Post?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var UserSV: UIStackView!{
    didSet{
        UserSV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userSVTapped)))
    }
    }
    
    @IBOutlet weak var PostTagsCV: UICollectionView!{
        didSet{
            PostTagsCV.delegate = self
            PostTagsCV.dataSource = self
        }
        }
   
    @IBOutlet weak var SaveOutlet: UIButton!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var likesNumber: UILabel!
    @IBOutlet weak var cellView: UIView! 
    @IBOutlet weak var OwnerImage: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    // Mark: action
    @objc func userSVTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("userSVTapped"), object: nil, userInfo:["cell":self])

        
    }

    @IBAction func Like(_ sender: Any) {
     
    }
    
    @IBAction func Comments(_ sender: Any) {
  
        NotificationCenter.default.post(name: NSNotification.Name("ToCommentsPage"), object: nil, userInfo:["cell":self])
        
        
    }
    
    @IBAction func savePost(_ sender: Any) {
            SaveOutlet.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
            NotificationCenter.default.post(name: NSNotification.Name("SavePost"), object: nil, userInfo:["cell":self])
  
}
}

extension PostCell : UICollectionViewDelegate,UICollectionViewDataSource{
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

