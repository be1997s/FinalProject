//
//  GradientView.swift
//  FinalProject
//
//  Created by BE X on 20/05/1443 AH.
//

import UIKit

class GradientView: UIView {
     var topColor : UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
     var bottomColor : UIColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    
    var StartPointX : CGFloat = 0
    var StartPointY : CGFloat = 0
    var endPointX  : CGFloat = 1
    var endPointY  : CGFloat = 1
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: StartPointX, y: StartPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    

}

  
