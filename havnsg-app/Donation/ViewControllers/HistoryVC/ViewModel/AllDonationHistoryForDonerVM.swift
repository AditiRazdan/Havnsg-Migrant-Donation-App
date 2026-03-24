//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AllDonationHistoryForDonerVM : NSObject {
    var allDonationaHistoryData : [DonationAndReceiveHistoryDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getDonationHistory(viewController:UIViewController,userId: String,status: String){
        let url = ApiEndpoints.allDonationHistoryByStatus + userId + "/" + status
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: DonationAndReceiveHistorytM.self) { (result:DonationAndReceiveHistorytM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.allDonationaHistoryData = result?.data ?? []
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
