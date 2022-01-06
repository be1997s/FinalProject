//
//  SignInViewController.swift
//  FinalProject
//
//  Created by BE X on 19/05/1443 AH.
//

import UIKit
import CleanyModal
import SPIndicator
class SignInViewController: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstname.text = "Bashayer"
        lastname.text = "Mohammed"
        signin = ViewStyle.ViewcornerRadius(view: signin) as? UIButton
         
    }
    
    @IBAction func signin(_ sender: Any) {
        
        PostApi.SignIn(firstname: firstname.text!, lastname: lastname.text!) { user,message  in
        
            if message != nil {
                let alert = MyAlertViewController(
                    title: "Error",
                    message: message,
                    imageName: "exclamation")
                alert.addAction(title: "OK", style: .default)
                self.present(alert, animated: true, completion: nil)
            
               
            } else {
                
            
                
                SPIndicator.present(title: "Sucsess", message: "Sign in Sucsessfuly!", preset: .done ,completion: {
                    let vc = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC

                    self.present(vc, animated: true)
                   
                        let vc1 = vc.viewControllers?[0] as! HomeViewController
                        UserManager.LoggedInUser = user
            }
            
        
 
                
           ) }
        }
           
    
    }
}
