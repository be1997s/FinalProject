//
//  Comments.swift
//  FinalProject
//
//  Created by BE X on 13/05/1443 AH.
//

import Foundation
struct Comments : Decodable {
    var id : String
    var message : String
    var owner : User
}
