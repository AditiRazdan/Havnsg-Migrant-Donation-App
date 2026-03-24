//
//  PendingRequestM.swift
//  Donation
//
//  Created by Kanhu Dash on 29/10/21.
//

import Foundation

struct PendingRequestM : Codable {
    let success: Bool?
    let msg: String?
    let data: [PendingRequestData]?
}

struct PendingRequestData : Codable {
    let v : Int?
    let id : String?
    let address : String?
    let categoryId : String?
    let createdBy : String?
    let cretedAt : String?
    let deliveryType : String?
    let descriptionField : String?
    let image : String?
    let isActive : Bool?
    let modifiedAt : String?
    let modifiedBy : String?
    let region : String?
    let status : String?
    let subcategoryId : String?
    let userId : String?
    let subCategoryName : String?
    let categoryName : String?

    enum CodingKeys: String, CodingKey {
            case v = "__v"
            case id = "_id"
            case address = "address"
            case categoryId = "categoryId"
            case createdBy = "createdBy"
            case cretedAt = "cretedAt"
            case deliveryType = "deliveryType"
            case descriptionField = "description"
            case image = "image"
            case isActive = "isActive"
            case modifiedAt = "modifiedAt"
            case modifiedBy = "modifiedBy"
            case region = "region"
            case status = "status"
            case subcategoryId = "subcategoryId"
            case userId = "userId"
            case categoryName = "categoryName"
            case subCategoryName = "subCategoryName"
    }

    init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            v = try values.decodeIfPresent(Int.self, forKey: .v)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            address = try values.decodeIfPresent(String.self, forKey: .address)
            categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
            createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
            cretedAt = try values.decodeIfPresent(String.self, forKey: .cretedAt)
            deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
            descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
            modifiedAt = try values.decodeIfPresent(String.self, forKey: .modifiedAt)
            modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
            region = try values.decodeIfPresent(String.self, forKey: .region)
            status = try values.decodeIfPresent(String.self, forKey: .status)
            subcategoryId = try values.decodeIfPresent(String.self, forKey: .subcategoryId)
            userId = try values.decodeIfPresent(String.self, forKey: .userId)
        subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
        categoryName =  try values.decodeIfPresent(String.self, forKey: .categoryName)
    }
}
