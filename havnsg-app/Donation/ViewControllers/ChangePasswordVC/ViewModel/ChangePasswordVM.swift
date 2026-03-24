//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation
import UIKit

class ChangePasswordVM: NSObject {
    var changePasswordData: ChangePasswordM?
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func changePasswordApi(viewController: UIViewController, param: [String:Any]) {
        APIHandler.shared.callServiceMethodPOST(
            viewController: viewController,
            parameters: param,
            keyURL: ApiEndpoints.changePassword,
            isShowLoader: true,
            isHideLoader: true,
            loadingMsg: ""
        ) { (result: ChangePasswordM?, error) in

            DispatchQueue.main.async {
                if error == nil, result?.success == true {

                    let alert = UIAlertController(title: "", message: result?.msg ?? "Password changed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        DispatchQueue.main.async {
                            if let nav = viewController.navigationController {
                                if let loginVC = nav.viewControllers.first(where: { $0 is LoginViewController }) {
                                    nav.popToViewController(loginVC, animated: true)
                                } else {
                                    nav.popToRootViewController(animated: true) // fallback
                                }
                            } else {
                                viewController.dismiss(animated: true)
                            }
                        }
                    })
                    viewController.present(alert, animated: true)

                } else {
                    let msg = result?.msg ?? "Something went wrong"
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    viewController.present(alert, animated: true)
                }
            }
        }
    }

}
