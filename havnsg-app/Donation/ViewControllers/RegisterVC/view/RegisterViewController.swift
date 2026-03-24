//
//  RegisterViewController.swift
//  Donation
//
//  Created by naxtre on 9/21/21.
//

import UIKit
import DropDown

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var textFeild_firstName: UITextField!
    
    @IBOutlet weak var textFeild_lastName: UITextField!
    
    @IBOutlet weak var textFeild_email: UITextField!
    
    @IBOutlet weak var textFeild_phoneNumber: UITextField!
    
    @IBOutlet weak var textFeild_password: UITextField!
    
    @IBOutlet weak var textFeild_confirmPassword: UITextField!
    
    @IBOutlet weak var textFeild_Address: UITextView!
    
    @IBOutlet weak var textFeild_Region: UITextField!
    
    @IBOutlet weak var imageView_donor: UIImageView!
    
    @IBOutlet weak var imageView_receiver: UIImageView!
    
    @IBOutlet weak var imageView_volunteer: UIImageView!
    
    @IBOutlet weak var btn_Eye_TextPassword: UIButton!
    
    @IBOutlet weak var btn_Eye_TextConfirmPassword: UIButton!
    
    var lblPlaceHolder : UILabel!
    
    let obj_SignUpVM = SignUpVM()
    var userType : UserType = .doner
//    let obj_InitialDataVM = InitialDataVM()
    let initialData = InitialDataVM()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           textFeild_Address.delegate = self
           lblPlaceHolder = UILabel()
           lblPlaceHolder.text = "Address"
           lblPlaceHolder.font = UIFont.systemFont(ofSize: textFeild_Address.font!.pointSize)
           lblPlaceHolder.sizeToFit()
        textFeild_Address.addSubview(lblPlaceHolder)
           lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (textFeild_Address.font?.pointSize)! / 2)
        lblPlaceHolder.textColor = textFeild_Address.textColor
           lblPlaceHolder.isHidden = !textFeild_Address.text.isEmpty
        self.btn_Eye_TextPassword.setTitle("", for: .normal)
        self.btn_Eye_TextConfirmPassword.setTitle("", for: .normal)
        self.textFeild_Region.delegate = self
        dropDown.anchorView = textFeild_Region
        initialData.getInitialData(viewController: self)
        var regions:[String] = []
        initialData.bindToController = {
            for i in self.initialData.initialData?.regions ?? [] {
                regions.append(i)
            }
            self.dropDown.dataSource = regions
        }
        dropDown.selectionAction = { (index: Int, item: String) in
            self.textFeild_Region.text = item
        }
        // Do any additional setup after loading the view.
        self.setUI()
    }
    
    
    func setUI()
    {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "eyeOpen"), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
//        button.frame = CGRect(x: CGFloat(textFeild_password.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
//        button.addTarget(self, action: #selector(clickEyeButton), for: .touchUpInside)
//        textFeild_password.rightView = button
//        textFeild_password.rightViewMode = .always
//        textFeild_confirmPassword.rightView = button
//        textFeild_confirmPassword.rightViewMode = .always
        
        Utility().changePlaceholderTetxColor(textField: textFeild_firstName, title: textFeild_firstName.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        Utility().changePlaceholderTetxColor(textField: textFeild_lastName, title: textFeild_lastName.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        
        Utility().changePlaceholderTetxColor(textField: textFeild_email, title: textFeild_email.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        Utility().changePlaceholderTetxColor(textField: textFeild_phoneNumber, title: textFeild_phoneNumber.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        
        Utility().changePlaceholderTetxColor(textField: textFeild_confirmPassword, title: textFeild_confirmPassword.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        
        Utility().changePlaceholderTetxColor(textField: textFeild_password, title: textFeild_password.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        
//        Utility().changePlaceholderTetxColor(textField: textFeild_Address, title: textFeild_Address.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        
        Utility().changePlaceholderTetxColor(textField: textFeild_Region, title: textFeild_Region.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
    }
    
    @objc func clickEyeButton(_ sender:UIButton) {
        
    }
    
    func checkValidation() -> Bool {
        if (textFeild_email.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter email", controller: self)
            
            return false
        }
        else if (textFeild_password.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter password", controller: self)
            
            return false
        }
        else if (textFeild_firstName.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter first name", controller: self)
            
            return false
        }
        else if (textFeild_lastName.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter last name", controller: self)
            
            return false
        }
        else if (textFeild_phoneNumber.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter phone number", controller: self)
            
            return false
        }
        else if (textFeild_password.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter password", controller: self)
            return false
        }
        else if !(Utility().isValidPassword(testPwd: textFeild_password.text!)){
            Utility().showPositiveMessage(message: "Password must be 8 digit and must contain one small,one capital and one special character.", controller: self)
            return false
        }
        else if (textFeild_confirmPassword.text!.isEmpty) {
            Utility().showPositiveMessage(message: "Please enter confirm password", controller: self)
            
            return false
        }
        else if textFeild_confirmPassword.text != textFeild_password.text {
            Utility().showPositiveMessage(message: "Password should be equal to confirm password", controller: self)
            return false
        }
        else if textFeild_phoneNumber.text?.count != 8 {
            Utility().showPositiveMessage(message: "Please enter 8-digit phone number", controller: self)
            
            return false
        }
        else if !(Utility().isValidEmail(testEmail: textFeild_email.text)) {
            Utility().showPositiveMessage(message: "Please enter valid email ID", controller: self)
            return false
        }
        else {
            return true
        }
        
    }
    
    func callRegisterApi() {
        let dataDict = ["firstName":textFeild_firstName.text!,"lastName":textFeild_lastName.text!,"email":textFeild_email.text!,"mobile":textFeild_phoneNumber.text!,"password":textFeild_password.text!,"confirmPassword":textFeild_confirmPassword.text!,"userType":userType.rawValue,"region":textFeild_Region.text!,"address":textFeild_Address.text!,"deviceType":"IOS","deviceToken":"appDelegate.deviceTokenString"] as [String : Any]
        self.obj_SignUpVM.signUpApi(viewController: self, param: dataDict)
        self.obj_SignUpVM.bindToLoginController = {
            let controller = LoginViewController.instatiate(from: .Main)
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    @IBAction func BtnClicked_submit(_ sender: Any) {
        if checkValidation() {
            self.callRegisterApi()
        }
    }
    
    @IBAction func BtnClicked_haveAccount(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func BtnClicked_back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEyeClicked(_ sender:UIButton) {
        if sender.tag == 0 {
            textFeild_password.isSecureTextEntry = !textFeild_password.isSecureTextEntry
            if textFeild_password.isSecureTextEntry {
                sender.setImage(UIImage(named: "eyeOpen"), for: .normal)
            } else {
                sender.setImage(UIImage(named: "eyeClose"), for: .normal)
            }
        } else {
            textFeild_confirmPassword.isSecureTextEntry = !textFeild_confirmPassword.isSecureTextEntry
            if textFeild_confirmPassword.isSecureTextEntry {
                sender.setImage(UIImage(named: "eyeOpen"), for: .normal)
            } else {
                sender.setImage(UIImage(named: "eyeClose"), for: .normal)
            }
        }
    }
    @IBAction func BtnCLicked_userType(_ sender: UIButton) {
        switch (sender.tag){
        case 0:
            userType = .doner
            setUserType(selectedImage: imageView_donor, unselectedImageView1: imageView_receiver, unselectedImageView2: imageView_volunteer)
            break
            
        case 1:
            userType = .receiver
            setUserType(selectedImage: imageView_receiver, unselectedImageView1: imageView_donor, unselectedImageView2: imageView_volunteer)
            break
            
        default:
            userType = .volunteer
            setUserType(selectedImage: imageView_volunteer, unselectedImageView1: imageView_donor, unselectedImageView2: imageView_receiver)
            break
        }
    }
    
    func setUserType(selectedImage : UIImageView, unselectedImageView1: UIImageView,unselectedImageView2: UIImageView ) {
        if #available(iOS 13.0, *) {
            selectedImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            unselectedImageView1.image = UIImage(systemName: "checkmark.circle")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            unselectedImageView2.image = UIImage(systemName: "checkmark.circle")
        } else {
            // Fallback on earlier versions
        }
    }
    
}
extension RegisterViewController : UITextFieldDelegate,UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            dropDown.show()
        return false
    }
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
}
