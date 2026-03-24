//
//  UserProfileM.swift
//  Donation
//
//  Created by Kanhu Dash on 12/10/21.
//

import Foundation

struct UserProfileM : Codable {
    let success: Bool?
    let msg: String?
    let data: UserProfileData?
}

struct UserProfileData : Codable {
    let _id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let mobile: String?
    let userType: String?
    let region: String?
    let address: String?
}
