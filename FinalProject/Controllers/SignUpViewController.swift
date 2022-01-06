//
//  SignUpViewController.swift
//  FinalProject
//
//  Created by BE X on 16/05/1443 AH.
//

import UIKit
import CleanyModal
import SPIndicator
class SignUpViewController: UIViewController {

    @IBOutlet weak var fristname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signUpOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        signUpOutlet = ViewStyle.ViewcornerRadius(view: signUpOutlet) as? UIButton
         

        
    }

    // MARK: - Action

    @IBAction func SignUpButton(_ sender: Any) {
      
        PostApi.NewUser(fristname: fristname.text!, lastname: lastname.text!, email: email.text!,completionhandler: {user,message in
                if message != nil && user == nil{
                    let alert = MyAlertViewController(
                        title: "Error",
                        message: message,
                        imageName: "exclamation")
                    alert.addAction(title: "OK", style: .default)
                    self.present(alert, animated: true, completion: nil)
                
                   
                } else {
                    SPIndicator.present(title: "Sucsess", message: "Sign Up Sucsessfuly!", preset: .done ,completion: {
                        let vc = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
                        self.present(vc, animated: true)
                        UserManager.LoggedInUser = user
                        
                }
                
            
     
                    
               ) }
     
    })
    
}

}



