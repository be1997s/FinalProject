//
//  UnauthorizedViewController.swift
//  FinalProject
//
//  Created by BE X on 29/05/1443 AH.
//

import UIKit

class UnauthorizedViewController: UIViewController {

    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var signin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signin = ViewStyle.ViewcornerRadius(view: signin) as! UIButton
        signup = ViewStyle.ViewcornerRadius(view: signup) as! UIButton
        
    }
    



}
