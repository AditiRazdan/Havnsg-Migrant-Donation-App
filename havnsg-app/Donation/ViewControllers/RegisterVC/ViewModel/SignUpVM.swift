//
//  SignUpVM.swift
//  Donation
//
//  Created by user922181 on 9/23/21.
//

import Foundation
import UIKit

class SignUpVM: NSObject {
    var signUpData: RegisterUserData?
    var bindToLoginController: (() -> ()) = {}
     
    override init() {
        super.init()
    }
    
    func signUpApi(viewController:UIViewController,param:[String:Any]) {
        print(param)
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.register, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result: SignUpM?, error) in
            if error == nil {
                if let success = result?.success, success == true {
                    self.signUpData = result?.data
                    Utility().showAlert(Title: "Success", message: result?.msg ?? "", viewcontroller: viewController) {
                        self.bindToLoginController()
                    }
                    debugPrint(result as Any)
                } else {
                    let alertController = UIAlertController(title: "", message: result?.error?[0].msg, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    viewController.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "", message: "Something went wrong", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}
