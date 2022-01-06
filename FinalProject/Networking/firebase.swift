//
//  firebase.swift
//  FinalProject
//
//  Created by BE X on 01/06/1443 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
class firebase {
static let userid = UserManager.LoggedInUser!.id
   static let db = Firestore.firestore()


static func saveData(postid:String){
        var arr = [postid]
        db.collection("SavePosts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
               
                for document in querySnapshot!.documents {
                    if document.get("UserId") as! String == userid {
                    let washingtonRef = self.db.collection("SavePosts").document(document.documentID)

                        if (document.get("PostId") as! [String]).contains(postid){
                    washingtonRef.updateData([
                    // Atomically remove a region from the "regions" array field.
                    "PostId": FieldValue.arrayRemove(arr)])
                        print("value removed from  : \(document.get("PostId")!)")
                    break  }
                    else if  !(document.get("PostId") as! [String]).contains(postid) {
                    // Atomically add a new region to the "regions" array field.
                        washingtonRef.updateData([
                            "PostId": FieldValue.arrayUnion(arr)])
                        print("value added to : \(document.get("PostId")!)")

                        break
                    }
                        
                    }
                    if document.isEqual(querySnapshot!.documents.last) && document.get("UserId") as! String != userid {
                        // Add a new document with a generated ID
                                            var ref: DocumentReference? = nil
                                                    ref = self.db.collection("SavePosts").addDocument(data: [
                                                "UserId": userid,
                                                "PostId": [postid],
                                            ]) { err in
                                                if let err = err {
                                                    print("Error adding document: \(err)")
                                                } else {
                                                    print("Document added with ID: \(ref!.documentID)")
                                                }

                    }

}
            }
        }
        }
    }
    

    
    
    
    
}

