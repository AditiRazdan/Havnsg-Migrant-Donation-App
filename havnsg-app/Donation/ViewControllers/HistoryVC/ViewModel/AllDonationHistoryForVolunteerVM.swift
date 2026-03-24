//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AllDonationHistoryForVolunteerVM : NSObject {
    var allDonationaHistoryData : [DonationAndReceiveHistoryDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getAllDonationHistoryByRegion(viewController:UIViewController,region: String){
        let url = ApiEndpoints.allDonationHistoryByRegion + region
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
