//
//  ImageStyle.swift
//  FinalProject
//
//  Created by BE X on 16/05/1443 AH.
//

import Foundation
import UIKit
class ViewStyle {
  

    static func ViewShadow (view : UIView  ) -> UIView {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        return view
    }
    
    static func ViewcornerRadius (view : UIView) -> UIView {
        var cornerRadious: CGFloat = 10 {
                didSet {
                    let path = UIBezierPath(roundedRect: view.layer.bounds, byRoundingCorners: [.topLeft, .topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: cornerRadious, height: cornerRadious))
                    let mask = CAShapeLayer()
                    mask.path = path.cgPath
                    view.layer.mask = mask
                }
            }
        view.layer.cornerRadius = cornerRadious
        return view
    }
    
    static func ViewCircler (view : UIView) -> UIView {
        view.layer.cornerRadius = view.frame.size.width/2
        return view

    }
    
    static func Viewborder (view : UIView) -> UIView {
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.white.cgColor
        return view

            }

    
 

}

