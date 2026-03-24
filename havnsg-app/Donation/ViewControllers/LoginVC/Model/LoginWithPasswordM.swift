//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation

struct LoginWithPasswordM : Codable {
    var success: Bool?
    var msg: String?
    var error: String?
    var data: UserData?
}

struct UserData: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var userType: String?
    var _id: String?
    var authToken: String?
    var region: String?
    var address : String?
}
