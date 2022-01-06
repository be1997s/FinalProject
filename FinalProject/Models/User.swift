//
//  User.swift
//  FinalProject
//
//  Created by BE X on 11/05/1443 AH.
//

import Foundation

struct User : Decodable {
    var id : String
    var firstName : String
    var lastName : String
    var picture : String?
    var title : String?
    var gender : String?
    var email : String?
    var location : location?
    var phone : String?
    var dateOfBirth : String?
}
