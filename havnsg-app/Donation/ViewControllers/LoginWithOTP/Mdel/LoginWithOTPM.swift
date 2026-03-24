//
//  LognWithOTPM.swift
//  Donation
//
//  Created by user922181 on 9/24/21.
//

import Foundation

struct LoginWithOTPM: Codable {
    var success: Bool?
    var msg: String?
    var error: String?
    var data: OTPData?
}

struct OTPData: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var userType: String?
    var _id: String?
    var authToken: String?
    var address : String?
}

