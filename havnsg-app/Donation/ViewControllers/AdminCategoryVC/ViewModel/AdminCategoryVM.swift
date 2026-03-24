//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AdminCategoryVM : NSObject {
    var categoryData : [AdminCategoryDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getCategoryApi(viewController:UIViewController){
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: ApiEndpoints.getCategories, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: AdminCategoryM.self) { (result:AdminCategoryM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.categoryData = result?.data ?? []
                    self.bindToController()
                }
                else {
//                    viewController.showAlert(message: ErrorMSG.Server_Error.rawValue, title: "", buttonName: "Ok")
                }
            }
            else{
//                viewController.showAlert(message: error.debugDescription, title: "", buttonName: "Ok")
            }
        }
    }
}
