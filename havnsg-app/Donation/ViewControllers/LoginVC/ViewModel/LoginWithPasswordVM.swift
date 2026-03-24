//
//  LoginWithPasswordM.swift
//  Donation
//
//  Created by user922181 on 9/22/21.
//

import Foundation
import UIKit

class LoginWithPasswordVM: NSObject {
    var loginData: UserData?
    var bindToController:(() -> ()) = {}
    
    override init() {
        super.init()
    }
    
    func loginWithPasswordApi(viewController: UIViewController,param:[String:Any]) {
        print("📩 Login API Params:", param)
        APIHandler.shared.callServiceMethodPOST(viewController: viewController, parameters: param, keyURL: ApiEndpoints.loginUserByPassword, isShowLoader: true, isHideLoader: true, loadingMsg: "") { (result:LoginWithPasswordM?, error) in
                if error == nil {
                    if let success = result?.success , success {
                        self.loginData = result?.data
                        obj_UserDefault.setValue(self.loginData?._id, forKey: "userId")
                        obj_UserDefault.setValue(self.loginData?.authToken, forKey: "authToken")
                        obj_UserDefault.setValue(true, forKey: "autoLogin")
                        obj_UserDefault.setValue(result?.data?.userType, forKey: "userType")
                        obj_UserDefault.setValue(result?.data?.address, forKey: "address")
                        obj_UserDefault.setValue(result?.data?.region, forKey: "region")
                        print("UserDefaults:", obj_UserDefault.dictionaryRepresentation())
                        debugPrint(result as Any)
                        self.bindToController()
                    } else {
                        let alertController = UIAlertController(title: "", message: result?.error ?? "", preferredStyle: .alert)
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
