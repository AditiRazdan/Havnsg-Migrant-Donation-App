//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation
import UIKit

class ConfirmOTPVM: NSObject {
    var confirmOTPData: ConfirmOTPData?
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func confirmOTPApi(viewController: UIViewController,param:[String:Any]) {
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.validateLoginOTP, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:ConfirmOTPM?, error) in
            if error == nil {
                if let success = result?.success , success {
                    self.confirmOTPData = result?.data
                    obj_UserDefault.setValue(self.confirmOTPData?._id, forKey: "userId")
                    obj_UserDefault.setValue(self.confirmOTPData?.authToken, forKey: "authToken")
                    obj_UserDefault.setValue(true, forKey: "autoLogin")
                    obj_UserDefault.setValue(self.confirmOTPData?.userType, forKey: "userType")
                    debugPrint(result as Any)
//                    let alertController = UIAlertController(title: "", message: result?.msg ?? "", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//                    alertController.addAction(okAction)
//                    viewController.present(alertController, animated: true, completion: nil)
                    
                    self.bindToController()
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
    
    func resendOTPApi(viewController: UIViewController,param:[String:Any]) {
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.resendOTP, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:ConfirmOTPM?, error) in
            if error == nil {
                let alertController = UIAlertController(title: "", message: "OTP has been resend", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                viewController.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "", message: "something went wrong", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
