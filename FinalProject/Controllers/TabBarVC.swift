//
//  TabBarVC.swift
//  FinalProject
//
//  Created by BE X on 12/05/1443 AH.
//
import Foundation
import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CAShapeLayer()
               layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: self.tabBar.bounds.minY + 5, width: self.tabBar.bounds.width - 60, height: self.tabBar.bounds.height + 10), cornerRadius: (self.tabBar.frame.width/2)).cgPath
               layer.shadowColor = UIColor.lightGray.cgColor
               layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
               layer.shadowRadius = 25.0
               layer.shadowOpacity = 0.3
               layer.borderWidth = 1.0
               layer.opacity = 1.0
               layer.isHidden = false
               layer.masksToBounds = false
               layer.fillColor = UIColor.white.cgColor
         
               self.tabBar.layer.insertSublayer(layer, at: 0)
       
        if let items = self.tabBar.items {
          items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
        }
        
      
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.clipsToBounds = true
        self.tabBar.itemWidth = 30.0
        self.tabBar.itemPositioning = .centered
    
   
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }

        let timeInterval: TimeInterval = 0.5
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
  
    
   
}
 



