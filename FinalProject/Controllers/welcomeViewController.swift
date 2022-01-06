//
//  SignViewController.swift
//  FinalProject
//
//  Created by BE X on 21/05/1443 AH.
//

import UIKit
import Spring
class welcomeViewController: UIViewController {

    @IBOutlet weak var Signin: SpringButton!
    @IBOutlet weak var SignUp: SpringButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Signin = ViewStyle.ViewcornerRadius(view: Signin) as? SpringButton
        SignUp = ViewStyle.ViewcornerRadius(view: SignUp) as? SpringButton
        
        Signin.animation = "zoomIn"
        Signin.delay = 0.3
        Signin.duration = 1
        Signin.animate()
        SignUp.animation = "zoomIn"
        SignUp.delay = 0.5
        SignUp.duration = 1
        SignUp.animate()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
