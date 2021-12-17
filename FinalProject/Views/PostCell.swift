//
//  PostCell.swift
//  FinalProject
//
//  Created by BE X on 11/05/1443 AH.
//

import UIKit

class PostCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var likesNumber: UILabel!
    @IBOutlet weak var cellView: UIView! 
    @IBOutlet weak var OwnerImage: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var PostImage: UIImageView!
    @IBOutlet weak var postText: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
