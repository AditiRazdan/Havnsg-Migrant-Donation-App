//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation
import UIKit

class LoginWithOTPVM: NSObject {
    var otpData: OTPData?
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func loginWithOTPApi(viewController: UIViewController,param:[String:Any]) {
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.loginUserByOTP, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:LoginWithOTPM?, error) in
            if error == nil {
                if let success = result?.success , success {
                    self.otpData = result?.data
                    obj_UserDefault.setValue(self.otpData?._id, forKey: "userId")
                    obj_UserDefault.setValue(self.otpData?.authToken, forKey: "authToken")
                    obj_UserDefault.setValue(true, forKey: "autoLogin")
                    obj_UserDefault.setValue(result?.data?.userType, forKey: "userType")
                    obj_UserDefault.setValue(result?.data?.address, forKey: "address")
                    Utility().showAlert(Title: "Success", message: result?.msg ?? "", viewcontroller: viewController) {
                        self.bindToController()
                    }
                } else {
                    let alertController = UIAlertController(title: "", message: result?.error ?? "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    viewController.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "", message: "something went wrong", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
