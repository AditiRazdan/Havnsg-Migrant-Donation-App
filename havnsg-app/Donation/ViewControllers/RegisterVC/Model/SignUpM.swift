//
//  SignUpM.swift
//  Donation
//
//  Created by user922181 on 9/23/21.
//

import Foundation

struct SignUpM: Codable {
    var success: Bool
    var msg: String?
    var data: RegisterUserData?
    var error: [Error]?
    var errorCount: Int?
}

struct RegisterUserData: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var userType: String?
    var _id: String?
}

struct Error: Codable {
    var param: String?
    var msg: String?
}


enum UserType : String{
   case doner
   case receiver
   case volunteer
}

