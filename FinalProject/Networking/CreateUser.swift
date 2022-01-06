//
//  CreateUser.swift
//  FinalProject
//
//  Created by BE X on 16/05/1443 AH.
//

import Foundation
import Alamofire
import SwiftyJSON
class CreateUser : Api{
    
    //posts
    static func CreateUser(user : [String:String]){
        
        AF.request("https://dummyapi.io/data/v1/user/create" , method: .post, parameters: user, headers: header).responseJSON { response in
                    print(response)
                }
    }
    
 
    
 }
extension Dictionary {
    var jsonStringRepresentaiton: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .ascii)
    }
}

