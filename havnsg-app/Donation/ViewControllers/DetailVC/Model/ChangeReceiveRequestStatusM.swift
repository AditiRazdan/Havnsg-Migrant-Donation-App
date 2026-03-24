//
//  ChangeRequestStatus.swift
//  Donation
//
//  Created by Kanhu Dash on 23/10/21.
//

import Foundation

struct ChangeReceiveRequestStatusM : Codable {
    let success: Bool?
    let message: String?
    let errorCount: Int?
    let error: [ChangeReceiveStatusError]?
}

struct ChangeReceiveStatusError : Codable {
    let param : String?
    let msg : String?
}
