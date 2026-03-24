//
//  AdminSubCategoryM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
struct AdminSubCategoryM : Codable {
    
    let data : [AdminSubCategoryDatum]?
    let msg : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case msg = "msg"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AdminSubCategoryDatum].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
}

struct AdminSubCategoryDatum : Codable {
    
    let v : Int?
    let id : String?
    let createdBy : String?
    let cretedAt : String?
    let isActive : Bool?
    let modifiedAt : String?
    let modifiedBy : String?
    let name : String?
    let image : String?
    let categoryName : String?
    let parentCategory : String?
    
    
    enum CodingKeys: String, CodingKey {
        case v = "__v"
        case id = "_id"
        case createdBy = "createdBy"
        case cretedAt = "cretedAt"
        case isActive = "isActive"
        case modifiedAt = "modifiedAt"
        case modifiedBy = "modifiedBy"
        case name = "name"
        case image = "categoryImage"
        case categoryName = "categoryName"
        case parentCategory = "parentCategory"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        v = try values.decodeIfPresent(Int.self, forKey: .v)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
        cretedAt = try values.decodeIfPresent(String.self, forKey: .cretedAt)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        modifiedAt = try values.decodeIfPresent(String.self, forKey: .modifiedAt)
        modifiedBy = try values.decodeIfPresent(String.self, forKey: .modifiedBy)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        parentCategory = try values.decodeIfPresent(String.self, forKey: .parentCategory)
    }
    
}
