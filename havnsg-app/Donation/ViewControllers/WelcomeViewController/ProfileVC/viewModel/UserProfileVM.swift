//
//  AdminCategoryVM.swift
//  Donation
//
//  Created by user922181 on 9/29/21.
//

import Foundation
import UIKit

class UserProfileVM : NSObject {
    var userProfileData : UserProfileData?
    var bindToController: (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func getUserProfileApi(viewController:UIViewController,userId: String){
        let url = ApiEndpoints.getProfile  + userId
        APIHandler.shared.callServiceMethodGET(viewController: viewController, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", model: UserProfileM.self) { (result:UserProfileM?, error) in
            
            if error == nil {
                if let success = result?.success, success {
                    self.userProfileData = result?.data
                    obj_UserDefault.setValue(result?.data?.address, forKey: "address")
                    obj_UserDefault.setValue(result?.data?.region, forKey: "region")
                    self.bindToController()
                }
                else {
                    Utility().showPositiveMessage(message: "", controller: viewController)
                }
            }
            else{
            }
        }
    }
}

