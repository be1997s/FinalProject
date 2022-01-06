//
//  AccountViewController.swift
//  FinalProject
//
//  Created by BE X on 20/05/1443 AH.
//

import UIKit

class AccountViewController: UIViewController {
   let loggedUser = UserManager.LoggedInUser
    
    
    override func viewWillAppear(_ animated: Bool) {
        if UserManager.LoggedInUser == nil {
            let vc = storyboard?.instantiateViewController(identifier: "UnauthorizedViewController") as! UnauthorizedViewController
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var editinfo: UIStackView!{didSet{
        editinfo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(edituserinfo)))
}
    }
    @IBOutlet weak var showposts: UIStackView! {didSet{
        showposts.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ShowPostsSVTapped)))
}
    }
    @IBOutlet weak var logout: UIStackView!{didSet{
        logout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutt)))
}
    }
    @IBOutlet weak var OwnerImg: UIImageView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var userId: UILabel!
    override func viewDidLoad() {
 

        OwnerImg = ViewStyle.ViewCircler(view: OwnerImg) as! UIImageView
        OwnerImg = ViewStyle.Viewborder(view: OwnerImg) as! UIImageView

        view1 = ViewStyle.ViewcornerRadius(view: view1)
        view2 = ViewStyle.ViewcornerRadius(view: view2)
        view1 = ViewStyle.ViewShadow(view: view1)
        view2 = ViewStyle.ViewShadow(view: view2)
        
        if loggedUser?.picture != "" {
            OwnerImg.image = imageUrl.imageRELOAD(imageURL: (UserManager.LoggedInUser?.picture)!)
        }
        if let n = UserManager.LoggedInUser?.firstName {
        OwnerName.text = n + " " + UserManager.LoggedInUser!.lastName
        }
        userId.text = loggedUser?.id
        
        
        super.viewDidLoad()

    }
    
    
    @objc func edituserinfo(){
        let vc = self.storyboard?.instantiateViewController(identifier: "editInfoViewController") as! editInfoViewController
        self.present(vc, animated: true)
    }
@objc func ShowPostsSVTapped(){
    let vc = self.storyboard?.instantiateViewController(identifier: "UserPostsViewController") as! UserPostsViewController
    self.present(vc, animated: true)
}

    @objc func logoutt(){
        UserManager.LoggedInUser = nil
        let vc = self.storyboard?.instantiateViewController(identifier: "SignViewController") as! welcomeViewController
        self.present(vc, animated: true)
    }

}
