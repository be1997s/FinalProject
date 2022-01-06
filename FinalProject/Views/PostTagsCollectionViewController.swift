//
//  PostTagsCollectionViewController.swift
//  FinalProject
//
//  Created by BE X on 26/05/1443 AH.
//

import UIKit

class PostTagsCollectionViewController: UICollectionViewController {
    var PostTagsArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostTagsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostTagCell", for: indexPath) as! PostTagCell
        var tagName = PostTagsArray[indexPath.row]
        cell.tagName.text = tagName
        cell.view = ViewStyle.ViewcornerRadius(view: cell.view)
        cell.view.backgroundColor = .random()
        return cell
    }
    
    
}


