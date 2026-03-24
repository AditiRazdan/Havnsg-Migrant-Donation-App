//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AdminSubCategoryVM : NSObject {
    var subCategoryData : [AdminSubCategoryDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getSubCategoryApi(viewController:UIViewController,categoryId: String){
        let url = ApiEndpoints.getSubCategories + "/" + categoryId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: AdminSubCategoryM.self) { (result:AdminSubCategoryM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.subCategoryData = result?.data ?? []
                    self.bindToController()
                }
                else {
                }
            }
            else{
            }
        }
    }
}
