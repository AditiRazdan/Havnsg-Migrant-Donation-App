//
//  ForgotPasswordViewController.swift
//  Donation
//
//  Created by naxtre on 9/21/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtFeild_phoneNumber: UITextField!
    var obj_ForgetPassowrdVM = ForgetPassowrdOTPVM()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUI()
    }
    
    func setUI()
    {
        Utility().changePlaceholderTetxColor(textField: txtFeild_phoneNumber, title: txtFeild_phoneNumber.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
    }
    @IBAction func btn_SendOTP(_ sender: UIButton) {
        if txtFeild_phoneNumber.text == "" {
            Utility().showPositiveMessage(message: "Please enter Phone number", controller: self)
            return
        }
        
        if txtFeild_phoneNumber.text?.count != 8 {
           Utility().showPositiveMessage(message: "Please enter valid phone number", controller: self)
           return
        }
        
            self.obj_ForgetPassowrdVM.forgetPasswordApi(viewController: self, param: ["username": txtFeild_phoneNumber.text ?? ""])
            self.obj_ForgetPassowrdVM.bindToController = {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmOTPViewController") as! ConfirmOTPViewController
                nextVC.otpId = self.obj_ForgetPassowrdVM.otpData?._id ?? ""
                nextVC.screenType = .forgotPassWord
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
    }
    @IBAction func BtnClicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
