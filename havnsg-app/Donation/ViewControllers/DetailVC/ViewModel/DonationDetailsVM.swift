//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class DonationRequestDetailVM : NSObject {
    var requestDetails : DonationRequestDetailDatum?
    var bindToController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getDonationRequestDetailApi(viewController:UIViewController,requestId: String){
        let url = ApiEndpoints.getDonationRequestDetail + requestId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: DonationRequestDetailM.self) { (result:DonationRequestDetailM?, error) in
            
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
