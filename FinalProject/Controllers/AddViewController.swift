//
//  AddViewController.swift
//  FinalProject
//
//  Created by BE X on 20/05/1443 AH.
//

import UIKit
import FirebaseStorage
import SPIndicator
import NVActivityIndicatorView
class AddViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    @IBOutlet weak var loader: NVActivityIndicatorView!
    let storage = Storage.storage().reference()
    override func viewWillAppear(_ animated: Bool) {
        if UserManager.LoggedInUser == nil {
            let vc = storyboard?.instantiateViewController(identifier: "UnauthorizedViewController") as! UnauthorizedViewController
            present(vc, animated: true, completion: nil)
        }
    }
    var URL2 :String?
    var tagsArray : [String] = []
    @IBOutlet weak var addTagsCV: UICollectionView!
    @IBOutlet weak var uploadedimg: UIImageView!
    @IBOutlet weak var textfield: UITextView!
    @IBOutlet weak var addimage: UIButton!
    @IBOutlet weak var addtag: UIButton!
    @IBOutlet weak var tagtext: UITextField!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var publish: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTagsCV.delegate = self
        addTagsCV.dataSource = self
        
        addimage = ViewStyle.ViewcornerRadius(view: addimage) as?  UIButton
        addtag = ViewStyle.ViewcornerRadius(view: addtag) as?  UIButton
        addimage = ViewStyle.ViewcornerRadius(view: addimage) as?  UIButton
        
        view1 = ViewStyle.ViewcornerRadius(view: view1) as?  UIView
        view1 = ViewStyle.ViewShadow(view: view1) as?  UIView
        
        view2 = ViewStyle.ViewcornerRadius(view: view2) as?  UIView
        view2 = ViewStyle.ViewShadow(view: view2) as?  UIView
        publish = ViewStyle.ViewcornerRadius(view: publish) as?  UIButton
        NotificationCenter.default.addObserver( self, selector: #selector(removeCell), name : NSNotification.Name(rawValue: "removeCell"), object: nil)
    
        let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 0
                layout.minimumLineSpacing = 5
                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                self.addTagsCV.collectionViewLayout = layout
       
            
     
              super.viewDidLoad()
    
    }
    @objc func removeCell(notification : Notification){
   
        if let cell = notification.userInfo?["cell"] as? UICollectionViewCell {
            if let index = addTagsCV.indexPath(for: cell){
                
                tagsArray.remove(at: index.row)
                addTagsCV.reloadData()
            }
    }
    }
    
//Action
    
    @IBAction func addtagButton(_ sender: Any) {
        if let tag = tagtext.text {
        tagsArray.append(tag)
        addTagsCV.reloadData()
        tagtext.text = ""
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){

        picker.dismiss(animated: true, completion: nil)
        
        loader.startAnimating()
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        let name = randomString(length: 10)
        self.storage.child("images/\(name).png").putData(imageData, metadata: nil) {_, err in
            guard  err == nil else {
              print("Failed to upload")
                return
            }
            self.storage.child("images/\(name).png").downloadURL{ URL, err in
                guard let urll = URL, err == nil else {
                  print(err)
                    return
                }
                let Stringurl = urll.absoluteString
                print("Download URL :\(Stringurl)")
                self.URL2 = Stringurl
                
                UserDefaults.standard.setValue(Stringurl, forKey: "url")
                SPIndicator.present(title: "Sucsess", message: "image uploaded Sucsessfuly!", preset: .done) {
                    self.uploadedimg.image = imageUrl.imageRELOAD(imageURL: self.URL2!)
                }
                
             }
        }
        loader.stopAnimating()

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){}

    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }

    @IBAction func addImg(_ sender: Any) {
        
    let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing=true
        present(picker, animated: true)
        
    }
    
    @IBAction func publishButton(_ sender: Any) {
        PostApi.addPost(id: (UserManager.LoggedInUser?.id)!, text: textfield.text,image : URL2, tags: tagsArray,completionhandler: {
            SPIndicator.present(title: "Sucsess", message: "Post added Sucsessfuly!", preset: .done ,completion: {
                NotificationCenter.default.post(name: NSNotification.Name("updatedata"), object: nil)
                let vc = self.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
                self.present(vc, animated: true)
               
      
        })
        })
    }
    
    @IBAction func addimageButton(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddTagsCollectionViewCell", for: indexPath) as! AddTagsCollectionViewCell
        
        cell.tagName.text = tagsArray[indexPath.row]

        cell.view.backgroundColor = .random()
        cell.view = ViewStyle.ViewcornerRadius(view: cell.view)
        cell.layer.borderWidth = cell.tagName.layer.borderWidth
       return cell
    
    }
   
    
    
}

