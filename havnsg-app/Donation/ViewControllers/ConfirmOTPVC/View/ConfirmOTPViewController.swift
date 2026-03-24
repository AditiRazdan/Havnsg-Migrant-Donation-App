//
//  ConfirmOTPViewController.swift
//  Donation
//
//  Created by naxtre on 9/21/21.
//

import UIKit

class ConfirmOTPViewController: UIViewController {

    @IBOutlet weak var txt_OTP: UITextField!
    var otpId = ""
    let obj_ConfirmOTPVM = ConfirmOTPVM()
    var screenType : ConfirmOTPScreenType = .LoginWithOTP
    let obj_loginVC = LoginViewController()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }
    
    func setUI()
    {
        Utility().changePlaceholderTetxColor(textField: txt_OTP, title: txt_OTP.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
    }
    
    
    @IBAction func btn_SubmitClicked(_ sender: UIButton) {
        
        if txt_OTP.text == "" {
            Utility().showPositiveMessage(message: "Please enter OTP", controller: self)
            return
        }
        
        if txt_OTP.text != "" {
            self.obj_ConfirmOTPVM.confirmOTPApi(viewController: self, param: ["id":otpId as Any, "otp":txt_OTP.text!,"deviceType":"IOS","deviceToken":appDelegate.deviceTokenString])
            self.obj_ConfirmOTPVM.bindToController = { [weak self] in
                
                if self?.screenType != .LoginWithOTP
                {
                    let controller = ChangePasswordViewController.instatiate(from: .Main)
                    controller.otp = self?.txt_OTP.text ?? ""
                    controller.otpId = self?.otpId ?? ""
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
                else
                {
                    let nextVC = self?.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                    self?.navigationController?.pushViewController(nextVC, animated: true)
//                    let controller = AdminCategoryViewController.instatiate(from: .Main)
//                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    
    @IBAction func btn_ResendOTPClicked(_ sender: UIButton) {
        self.obj_ConfirmOTPVM.resendOTPApi(viewController: self, param: ["id":otpId as Any])
    }
    
    @IBAction func BtnClicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
