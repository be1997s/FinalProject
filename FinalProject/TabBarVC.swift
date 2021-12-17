//
//  TabBarVC.swift
//  FinalProject
//
//  Created by BE X on 12/05/1443 AH.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChangeTabBarRadius()

    }
    func ChangeTabBarRadius() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 40
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]



    }


}
