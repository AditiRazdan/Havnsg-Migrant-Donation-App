//
//  ChangePasswordViewController.swift
//  Donation
//
//  Created by naxtre on 9/21/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var txt_NewPassowrd: UITextField!
    @IBOutlet weak var txt_ConfirmPassword: UITextField!
    let obj_ChangePasswordVM = ChangePasswordVM()
    var otp = ""
    var otpId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btn_Submit_Clicked(_ sender: UIButton) {
        print("✅ nav nil?", self.navigationController == nil)
        if txt_NewPassowrd.text == txt_ConfirmPassword.text {
            obj_ChangePasswordVM.changePasswordApi(viewController: self, param: ["id":otpId,"otp":otp,"password":txt_NewPassowrd.text ?? ""])
        }
    }
    
    @IBAction func BtnClicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
