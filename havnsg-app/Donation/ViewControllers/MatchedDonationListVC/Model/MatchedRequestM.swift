//
//  MatchedRequestM.swift
//  Donation
//
//  Created by Kanhu Dash on 28/10/21.
//

import Foundation

import Foundation

struct MatchedRequestM : Codable {
    
    let data : [MatchedRequestDatum]?
    let msg : String?
    let success : Bool?
}
struct MatchedRequestDatum : Codable {
    
    let id : String?
    let categoryDetails : MatchedRequestCategoryDetail?
    let donationId : String?
    let donerDetails : MatchedRequestDonerDetail?
    let initiatedBy : String?
    let receiveId : String?
    let receiverDetails : MatchedRequestReceiverDetail?
    let region : String?
    let subcategoryDetails : MatchedRequestSubcategoryDetail?
}
struct MatchedRequestSubcategoryDetail : Codable {
    let _id : String?
    let name : String?
}
struct MatchedRequestReceiverDetail : Codable {
    let _id : String?
    let email : String?
    let firstName : String?
    let lastName : String?
    let mobile : String?
    let region : String?
    let address : String?
}
struct MatchedRequestDonerDetail : Codable {
    let _id : String?
    let email : String?
    let firstName : String?
    let lastName : String?
    let mobile : String?
    let region : String?
    let address : String?
}
struct MatchedRequestCategoryDetail : Codable {
    let _id : String?
    let name : String?
}

