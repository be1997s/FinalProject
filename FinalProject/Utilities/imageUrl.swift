//
//  imageUrl.swift
//  FinalProject
//
//  Created by BE X on 15/05/1443 AH.
//

import Foundation
import UIKit

class imageUrl {
    
  static func imageRELOAD(imageURL : String) -> UIImage {

    var image : UIImage!
    let url1 = URL(string: imageURL)!
    if let data1 = try? Data(contentsOf: url1) {
               // Create Image and Update Image View
            image  = UIImage(data: data1)!

        }
        return image
  }
    
}
