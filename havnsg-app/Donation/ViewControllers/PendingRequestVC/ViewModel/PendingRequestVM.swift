//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class PendingRequestVM : NSObject {
    var allPendingData : [PendingRequestData] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getPendingRequests(viewController:UIViewController){
        let url = ApiEndpoints.allPendingRequests
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: PendingRequestM.self) { (result:PendingRequestM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.allPendingData = result?.data ?? []
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
