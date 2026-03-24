//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class PendingDonationVM : NSObject {
    var allPendingData : [PendingRequestData] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getPendingDonationRequests(viewController:UIViewController){
        let url = ApiEndpoints.allPendingDonationRequests
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: PendingRequestM.self) { (result:PendingRequestM?, error) in
            if error == nil {
                if let success = result?.success, success {
                    self.allPendingData = result?.data ?? []
                    self.bindToController()
                }
                else {
                    Utility().showPositiveMessage(message: result?.msg ?? "", controller: viewController)
                }
            }
            else{
                Utility().showPositiveMessage(message: "Something went wrong", controller: viewController)
            }
        }
    }
}
