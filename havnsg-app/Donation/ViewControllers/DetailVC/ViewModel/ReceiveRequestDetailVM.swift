//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class ReceiveRequestDetailVM : NSObject {
    var requestDetails : ReceiveRequestDetailDatum?
    var bindToController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getRequestDetailApi(viewController:UIViewController,requestId: String){
        let url = ApiEndpoints.getRecieveRequestDetail + requestId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: ReceiveRequestDetailM.self) { (result:ReceiveRequestDetailM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.requestDetails = result?.data
                    self.bindToController()
                    debugPrint(result as Any)
                }
                else {
                }
            }
            else{
            }
        }
    }
}
