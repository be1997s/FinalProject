//
//  TagsViewController.swift
//  FinalProject
//
//  Created by BE X on 23/05/1443 AH.
//

import UIKit
import NVActivityIndicatorView
class TagViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var Activityloader: NVActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
      var Tags = ["Emma", "Oliver", "Jack", "Olivia", "Harry", "Sophia"]
      var filtredTags : [String]!
    
     override func viewDidLoad() {
        
        super.viewDidLoad()
        Activityloader.startAnimating()
        collectionView.isHidden = true
        PostApi.gatTags { (array) in
            self.Tags = array
            self.filtredTags = self.Tags
            self.collectionView.reloadData()
            self.collectionView.isHidden = false
            self.Activityloader.stopAnimating()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        filtredTags = Tags
     

    }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            
            let tag = self.filtredTags[indexPath.item]
            cell.TagView.layer.cornerRadius = 10.0
            cell.TagView.layer.masksToBounds = true
            cell.TagView.backgroundColor = .random()
            cell.TagName.textColor = UIColor.white
            cell.TagName.textAlignment = .center
            cell.TagName.text = tag
            
            return cell      //return your cell
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return filtredTags.count
            
        }
    
    //MARK : Search Bar Config
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       filtredTags = []
        if searchBar.text == "" {filtredTags = Tags}
        else {
        for tag in Tags {
            if tag.lowercased().contains(searchBar.text!.lowercased()) {
                filtredTags.append(tag)
            }
        }
            
        }
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        let search = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCollectionReusableView", for: indexPath) as! SearchCollectionReusableView
        return search
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let SelectedTag = filtredTags[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
         vc.tag = SelectedTag
        self.present(vc, animated: true)
    }


}

//Random Colors
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
    
}
