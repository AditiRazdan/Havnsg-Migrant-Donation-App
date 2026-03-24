//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation
import UIKit

class ForgetPassowrdOTPVM: NSObject {
    var otpData: ForgetPasswordOTPData?
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func forgetPasswordApi(viewController: UIViewController,param:[String:Any]) {
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.forgetPassword, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:ForgetPassowrdM?, error) in
            if error == nil {
                if let success = result?.success , success {
                    self.otpData = result?.data
                    
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
