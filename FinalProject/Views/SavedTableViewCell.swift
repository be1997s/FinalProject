//
//  SavedTableViewCell.swift
//  FinalProject
//
//  Created by BE X on 01/06/1443 AH.
//

import UIKit

class SavedTableViewCell: UITableViewCell {
    var PostTagsArray : [String] = []
    var post : Post?
    
    @IBOutlet weak var likesNumber: UIButton!

    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var SavedOutlet: UIButton!
    @IBOutlet weak var UserSV: UIStackView!{
        didSet{
            UserSV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userSVTapped)))
        }
        }
    @IBOutlet weak var PostText: UILabel!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var PostTagsCV: UICollectionView!{
        didSet{
            PostTagsCV.delegate = self
            PostTagsCV.dataSource = self
        }
        }
    @IBOutlet weak var OwnerImage: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Mark: action
    @objc func userSVTapped(){
        NotificationCenter.default.post(name: NSNotification.Name("ToCommentsPage"), object: nil, userInfo:["cell":self])
        
    }

    @IBAction func like(_ sender: Any) {
    }
    @IBAction func Comments(_ sender: Any) {
    }
    
    @IBAction func SavePost(_ sender: Any) {
        SavedOutlet.setImage(UIImage.init(systemName: "bookmark.fill"), for: .normal)
        NotificationCenter.default.post(name: NSNotification.Name("SavePost"), object: nil, userInfo:["cell":self])
    }
}
extension SavedTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
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
