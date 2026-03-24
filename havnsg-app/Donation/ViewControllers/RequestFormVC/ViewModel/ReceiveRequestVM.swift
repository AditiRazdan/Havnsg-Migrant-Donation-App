//
//  FormRequestVM.swift
//  Donation
//
//  Created by Kanhu Dash on 16/10/21.
//

import Foundation
import UIKit

class ReceiveRequestVM : NSObject {
    var bindToController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func receiveRequestApi(viewController: UIViewController,param:[String:Any]) {
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.receiverRequest, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:ReceiveRequestM?, error) in
            if error == nil {
                if let success = result?.success , success {
                    debugPrint(result as Any)
                    self.bindToController()
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
