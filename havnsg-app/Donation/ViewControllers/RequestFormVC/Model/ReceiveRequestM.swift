//
//  FormRequestM.swift
//  Donation
//
//  Created by Kanhu Dash on 16/10/21.
//

import Foundation

struct ReceiveRequestM : Codable {
    let success : Bool?
    let message : String?
    let errorCount : Int?
    let error : [ErrorType]?
}

struct ErrorType : Codable {
    let param : String?
    let msg : String?
}

