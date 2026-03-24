//
//  ReceiveRequestEditVM.swift
//  Donation
//
//  Created by Kanhu Dash on 20/10/21.
//

import Foundation
import UIKit

class RequestEditVM: NSObject {
    
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func RequestEditApi(viewController: UIViewController,param:[String:Any],requestId: String) {
        let url = ApiEndpoints.editReceiveRequest + requestId
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:RequestEditM?, error) in
            if error == nil {
                if let success = result?.success , success {
                    Utility().showAlert(Title: "Success", message: result?.msg ?? "", viewcontroller: viewController) {
                        self.bindToController()
                    }
                } else {
                    let alertController = UIAlertController(title: "", message: result?.msg, preferredStyle: .alert)
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

