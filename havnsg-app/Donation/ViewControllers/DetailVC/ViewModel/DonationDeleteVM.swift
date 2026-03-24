//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class DonationDeleteVM : NSObject {
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func deleteDonationRequestApi(viewController:UIViewController,requestId: String){
        let url = ApiEndpoints.deleteDonationRequest + requestId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: AdminSubCategoryM.self) { (result:AdminSubCategoryM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
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
