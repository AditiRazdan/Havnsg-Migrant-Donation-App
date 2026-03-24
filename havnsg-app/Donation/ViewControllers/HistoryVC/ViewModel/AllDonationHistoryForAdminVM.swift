//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AllDonationHistoryForAdminVM : NSObject {
    var allDonationHistoryData : [DonationAndReceiveHistoryDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getDonationRequests(viewController:UIViewController,userId: String){
        let url = ApiEndpoints.allDonationHistory + userId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: DonationAndReceiveHistorytM.self) { (result:DonationAndReceiveHistorytM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.allDonationHistoryData = result?.data ?? []
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
