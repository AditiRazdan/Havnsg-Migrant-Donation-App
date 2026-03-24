//
//  ConfirmOTPM.swift
//  Donation
//
//  Created by user922181 on 9/25/21.
//

import Foundation

struct ConfirmOTPM : Codable {
    var sucess: Bool?
    var success: Bool?
    var msg: String?
    var error: String?
    var data: ConfirmOTPData?
}

struct ConfirmOTPData: Codable {
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var userType: String?
    var _id: String?
    var authToken: String?
}

enum ConfirmOTPScreenType : String{
    case LoginWithOTP
    case forgotPassWord
}
