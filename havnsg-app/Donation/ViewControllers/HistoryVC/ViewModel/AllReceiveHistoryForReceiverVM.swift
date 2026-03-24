//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AllReceiveHistoryForReceiverVM : NSObject {
    var allReceiveHistoryData : [DonationAndReceiveHistoryDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getReceiveHistory(viewController:UIViewController,userId: String){
        let url = ApiEndpoints.allReceiveHistory + userId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: DonationAndReceiveHistorytM.self) { (result:DonationAndReceiveHistorytM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.allReceiveHistoryData = result?.data ?? []
                    self.bindToController()
                }
                else {
                }
            }
            else{
            }
        }
    }
    func getReceiveHistoryByStatus(viewController:UIViewController,userId: String,status: String){
        let url = ApiEndpoints.allReceiveHistoryByStatus + userId + "/" + status
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: DonationAndReceiveHistorytM.self) { (result:DonationAndReceiveHistorytM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.allReceiveHistoryData = result?.data ?? []
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
