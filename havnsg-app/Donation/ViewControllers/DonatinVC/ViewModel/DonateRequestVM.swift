//
//  FormRequestVM.swift
//  Donation
//
//  Created by Kanhu Dash on 16/10/21.
//

import Foundation
import UIKit

class DonateRequestVM : NSObject {
    var bindToController : (() -> ()) = {}
    
    override init() {
        super.init()
    }
    func sendFormDataApi(viewController: UIViewController,param: [String:Any], formdata: NSMutableArray,url:String) {
        let url = ApiEndpoints.donateRequest + url
        APIHandler.shared.callServiceMethodMultiPart(formdata: formdata, parameters: param, name: "image", keyURL: url, isShowLoader: true, isHideLoader: true, loadingMsg: "", viewController: viewController) { (result: DonateRequestM?, error) in
            if error == nil {
                if let success = result?.success , success {
//                    self.changePasswordData = result
                    debugPrint(result as Any)
                    self.bindToController()
                } else {
                    let alertController = UIAlertController(title: "", message: result?.message, preferredStyle: .alert)
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
