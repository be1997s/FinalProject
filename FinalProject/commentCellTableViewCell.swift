//
//  commentCellVCTableViewCell.swift
//  FinalProject
//
//  Created by BE X on 13/05/1443 AH.
//

import UIKit

class commentCellTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var OwnerPic: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
