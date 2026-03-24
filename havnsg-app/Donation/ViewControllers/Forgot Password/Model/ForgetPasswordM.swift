//
//  ForgetPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/28/21.
//

import Foundation

struct ForgetPassowrdM: Codable {
    var success: Bool?
    var msg: String?
    var error: String?
    var data: ForgetPasswordOTPData?
}

struct ForgetPasswordOTPData: Codable {
    var userId: String?
    var createdTime:String?
    var expireTime:String?
    var _id: String?
}

