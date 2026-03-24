//
//  AddCategoryModel.swift
//  Donation
//
//  Created by naxtre on 9/29/21.
//

import UIKit

struct UpdateCategoryModel : Codable {

        let data : UpdateCategoryData?
        let msg : String?
        let success : Bool?
        let error : [Error]?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case msg = "msg"
                case success = "success"
                case error = "error"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(UpdateCategoryData.self, forKey: .data)
                msg = try values.decodeIfPresent(String.self, forKey: .msg)
                success = try values.decodeIfPresent(Bool.self, forKey: .success)
                error = try values.decodeIfPresent([Error].self, forKey: .error)
        }

}

struct UpdateCategoryData : Codable {

        let v : Int?
        let id : String?
        let createdBy : String?
        let cretedAt : String?
        let isActive : Bool?
        let modifiedAt : String?
        let modifiedBy : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case v = "__v"
                case id = "_id"
                case createdBy = "createdBy"
                case cretedAt = "cretedAt"
                case isActive = "isActive"
                case modifiedAt = "modifiedAt"
                case modifiedBy = "modifiedBy"
                case name = "name"
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
        }

}

