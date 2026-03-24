//
//  InitialDataM.swift
//  Donation
//
//  Created by Kanhu Dash on 10/11/21.
//

import Foundation

struct InitialDataM : Codable {

        let data : InitialDataDatum?
        let msg : String?
        let success : Bool?
}

struct InitialDataDatum : Codable {
        let deliveryTypes : [String]?
        let regions : [String]?
        let requestStatus : [String]?
}
