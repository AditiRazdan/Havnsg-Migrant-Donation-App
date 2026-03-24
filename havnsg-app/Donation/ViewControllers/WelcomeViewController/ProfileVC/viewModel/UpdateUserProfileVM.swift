//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation
import UIKit

class UpdateUserProfileVM: NSObject {
//    var updateProfileData: U?
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func updateProfileApi(viewController: UIViewController,param:[String:Any],userId: String) {
        let url = ApiEndpoints.updateProfile  + userId
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:UpdateUserProfileM?, error) in
            if error == nil {
                if let success = result?.success , success {
                    debugPrint(result as Any)
                    self.bindToController()
                } else {
                    let alertController = UIAlertController(title: "", message: result?.msg ?? "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(okAction)
                    viewController.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "", message: error?.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
