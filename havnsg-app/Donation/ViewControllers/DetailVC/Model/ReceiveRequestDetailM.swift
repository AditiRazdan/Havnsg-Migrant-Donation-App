//
//  ReceiveRequestDetailM.swift
//  Donation
//
//  Created by Kanhu Dash on 20/10/21.
//

import Foundation

struct ReceiveRequestDetailM : Codable {
    let data : ReceiveRequestDetailDatum?
    let msg : String?
    let success : Bool?
}

struct ReceiveRequestDetailDatum : Codable {
    let __v : Int?
    let _id : String?
    let address : String?
    let categoryId : String?
    let createdBy : String?
    let cretedAt : String?
    let deliveryType : String?
    let description : String?
    let isActive : Bool?
    let modifiedAt : String?
    let modifiedBy : String?
    let region : String?
    let status : String?
    let subcategoryId : String?
    let userId : String?
    let subCategoryName : String?
    let categoryName : String?
    let image : String?
}
