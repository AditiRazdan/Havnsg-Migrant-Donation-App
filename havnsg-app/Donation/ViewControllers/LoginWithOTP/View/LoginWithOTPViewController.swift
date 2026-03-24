//
//  LoginWithOTPViewController.swift
//  Donation
//
//  Created by naxtre on 9/22/21.
//

import UIKit

class LoginWithOTPViewController: UIViewController {

    
    @IBOutlet weak var txtFeild_phoneNumber: UITextField!
    var obj_LoginWithOTPVM = LoginWithOTPVM()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUI()
    }
    
    func setUI()
    {
        Utility().changePlaceholderTetxColor(textField: txtFeild_phoneNumber, title: txtFeild_phoneNumber.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
    }
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        let controller = RegisterViewController.instatiate(from: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signInWithPasswordClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btn_SendOTPClicked(_ sender: UIButton) {
        
        if txtFeild_phoneNumber.text == "" {
            Utility().showPositiveMessage(message: "Please enter Phone number", controller: self)
            return
        }
        
        if txtFeild_phoneNumber.text?.count != 8 {
           Utility().showPositiveMessage(message: "Please enter 8-digit phone number", controller: self)
           
           return
        }
        
        self.obj_LoginWithOTPVM.loginWithOTPApi(viewController: self, param: ["username": txtFeild_phoneNumber.text ?? ""])
        self.obj_LoginWithOTPVM.bindToController = {
            let controller = ConfirmOTPViewController.instatiate(from: .Main)
            controller.otpId = self.obj_LoginWithOTPVM.otpData?._id ?? ""
            controller.screenType = .LoginWithOTP
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func BtnClicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
