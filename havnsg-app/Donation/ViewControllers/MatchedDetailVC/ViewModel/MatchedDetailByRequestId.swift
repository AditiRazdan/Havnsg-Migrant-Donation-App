//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class MatchedDetailRequestIdVM : NSObject {
    var matchedRequestData : [MatchedRequestDatum] = []
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getMatchedRequestDetailsByRequestId(viewController:UIViewController,requestId:String){
        print(requestId)
        let url = ApiEndpoints.matchedRequestDetailsByRequestId + "/" + requestId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: MatchedRequestM.self) { (result:MatchedRequestM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.matchedRequestData = result?.data ?? []
                    self.bindToController()
                    print(result?.data ?? [])
                }
                else {
                    Utility().showPositiveMessage(message: result?.msg ?? "", controller: viewController)
                }
            }
            else{
                Utility().showPositiveMessage(
                    message: error?.localizedDescription ?? "Something went wrong",
                    controller: viewController
                )
            }
        }
    }
}
