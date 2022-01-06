//
//  accountProfileVC.swift
//  FinalProject
//
//  Created by BE X on 15/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView

class accountProfileVC: UIViewController {
    
    var user : User!
    @IBOutlet weak var ActivityLoader: NVActivityIndicatorView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var InfoView: UIView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Pic: UIImageView!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var gender: UIImageView!
   
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        InfoView = ViewStyle.ViewShadow(view: InfoView)
        InfoView = ViewStyle.ViewcornerRadius(view: InfoView)

        Pic = ViewStyle.ViewCircler(view: Pic) as! UIImageView
        Pic = ViewStyle.Viewborder(view: Pic) as! UIImageView
        ActivityLoader.startAnimating()
        InfoView.isHidden = true
        SetUpData()
        PostApi.gatProfileinfo (id : user.id,completionhandler: {
          Newuser in
          self.user = Newuser
        self.SetUpData()})
        self.InfoView.isHidden = false
        self.ActivityLoader.stopAnimating()

      
      
    }
    
    func SetUpData(){
        if user.phone != nil {phone.text = user.phone}
        if user.email != nil {email.text = user.email}
        if user.debugDescription != nil {dateOfBirth.text = user.dateOfBirth}
        if user.location != nil {
        location.text = user.location!.country + ", " + user.location!.city
        }
        
        Pic.image = imageUrl.imageRELOAD(imageURL: user.picture!)
        id.text = user.id
        if user.title != nil {
            Name.text = user.title ?? " "  + " " + user.firstName + " " + user.lastName
        }
           Name.text = user.firstName + " " + user.lastName
        if  user.gender == "male" {
            gender.image = UIImage(named: "male")
        } else {
            gender.image = UIImage(named: "female")

        }

        
    }
    
}
  


