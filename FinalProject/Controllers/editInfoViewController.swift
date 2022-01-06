//
//  editInfoViewController.swift
//  FinalProject
//
//  Created by BE X on 02/06/1443 AH.
//

import UIKit
import FirebaseStorage
import CleanyModal
import SPIndicator

class editInfoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let storage = Storage.storage().reference()
    var URL2 :String?
    var user = UserManager.LoggedInUser
    let genders = ["male","female"]
    var pickerview = UIPickerView()
    var datepickerview = UIDatePicker()

    @IBOutlet weak var infoview: UIView!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var dateofbirth: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var editOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.delegate = self
        pickerview.dataSource = self
        pic = ViewStyle.ViewCircler(view: pic) as! UIImageView
        pic = ViewStyle.Viewborder(view: pic) as! UIImageView
        infoview = ViewStyle.ViewcornerRadius(view: infoview)
        infoview = ViewStyle.ViewShadow(view: infoview)
        editOutlet = ViewStyle.ViewcornerRadius(view: editOutlet) as! UIButton

        if let image = UserManager.LoggedInUser?.picture {
            pic.image = imageUrl.imageRELOAD(imageURL: image)
    }
     
        name.text = user!.firstName + " " + user!.lastName
        
        if let phon = user?.phone {
            phone.text = phon
        }
        gender.inputView = pickerview
        createdatepicker()  
    }
    func createdatepicker()  {
        var toolbar = UIToolbar ()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done , target: nil, action: #selector(donepresed))
        toolbar.setItems([done ], animated: true)
        dateofbirth.inputAccessoryView=toolbar
        dateofbirth.inputView = datepickerview
        datepickerview.datePickerMode = .date
        toolbar.sizeToFit()
        if #available(iOS 13.4, *) {
             datepickerview.preferredDatePickerStyle = .wheels
        }
    }
   @objc func  donepresed() {
    self.dateofbirth.text = "\(datepickerview.date)"
    self.view.endEditing(true)
    }
  
    @IBAction func editpic(_ sender: Any) {
        let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing=true
            present(picker, animated: true)
            
    }
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){}
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }
        let name = randomString(length: 10)
        self.storage.child("userImg/\(name).png").putData(imageData, metadata: nil) {_, err in
            guard  err == nil else {
              print("Failed to upload")
                return
            }
            self.storage.child("userImg/\(name).png").downloadURL{ URL, err in
                guard let urll = URL, err == nil else {
                  print(err)
                    return
                }
                let Stringurl = urll.absoluteString
                print("Download URL :\(Stringurl)")
                self.URL2 = Stringurl
                SPIndicator.present(title: "Sucsess", message: "image uploaded Sucsessfuly!", preset: .done)
                self.pic.image = imageUrl.imageRELOAD(imageURL: self.URL2!)

             }
        }
    }

    @IBAction func edit(_ sender: Any) {
        PostApi.editUserinfo(id: user!.id, firstname: firstname.text ?? user!.firstName, picture: URL2 ?? "", phone: phone.text ?? "", dateOfBirth: dateofbirth.text ?? "", gender: gender.text ?? "") { user,message in
            if message != nil && user == nil{
                let alert = MyAlertViewController(
                    title: "Error",
                    message: message,
                    imageName: "exclamation")
                alert.addAction(title: "OK", style: .default)
                self.present(alert, animated: true, completion: nil)
            
               
            } else {
                SPIndicator.present(title: "Sucsess", message: "Updated Sucsessfuly!", preset: .done ,completion: {
                    self.dismiss(animated: true) {
                        UserManager.LoggedInUser = user
                    }
                    
            }
            
        
 
                
           ) }
 
}
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated:true,completion:nil)
    }
    
    
}
extension editInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = genders[row]
        gender.resignFirstResponder()
    }
    
}
