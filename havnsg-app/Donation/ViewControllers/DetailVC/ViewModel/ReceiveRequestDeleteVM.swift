//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class ReceiveRequestDeleteVM : NSObject {
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func deleteReceiveRequestApi(viewController:UIViewController,requestId: String){
        let url = ApiEndpoints.deleteReceiveRequest + requestId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: ReceiveRequestDeleteM.self) { (result:ReceiveRequestDeleteM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
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
