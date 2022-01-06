//
//  AddTagsCollectionViewCell.swift
//  FinalProject
//
//  Created by BE X on 29/05/1443 AH.
//

import UIKit

class AddTagsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var tagName: UILabel!
    @IBAction func remove(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("removeCell"), object: nil,userInfo: ["cell" : self])

    }
    override func awakeFromNib() {
            super.awakeFromNib()
        self.tagName.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        self.tagName.setContentHuggingPriority(.defaultHigh, for: .horizontal)
     }
    
}
