//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class AcceptRequestVM : NSObject {
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func acceptRequest(viewController:UIViewController,url: String){
        let url = url
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: AcceptRequestM.self) { (result:AcceptRequestM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.bindToController()
                    Utility().showPositiveMessage(message: "Request Accepted", controller: viewController)
                }
                else {
                    Utility().showPositiveMessage(message: result?.msg ?? "", controller: viewController)
                }
            }
            else{
                Utility().showPositiveMessage(message: "Something went wrong.", controller: viewController)
            }
        }
    }
}
