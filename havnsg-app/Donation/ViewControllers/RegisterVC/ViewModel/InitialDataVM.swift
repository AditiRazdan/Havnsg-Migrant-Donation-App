//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class InitialDataVM : NSObject {
    var initialData : InitialDataDatum?
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getInitialData(viewController:UIViewController){
        let url = ApiEndpoints.initialData
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: InitialDataM.self) { (result:InitialDataM?, error) in
            if error == nil {
                if let success = result?.success, success {
                    self.initialData = result?.data
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
