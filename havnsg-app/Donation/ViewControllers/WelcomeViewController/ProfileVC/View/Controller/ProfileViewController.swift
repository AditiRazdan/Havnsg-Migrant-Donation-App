//
//  ProfileViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 12/10/21.
//

import UIKit
import DropDown

class ProfileViewController: UIViewController {
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var img_Profile: UIImageView!
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_Last_Name: UITextField!
    @IBOutlet weak var txt_Email: UITextField!
    @IBOutlet weak var txt_Phone_Number: UITextField!
    @IBOutlet weak var txt_Address: UITextView!
    @IBOutlet weak var txt_Region: UITextField!
    
    let obj_UserProfileVM = UserProfileVM()
    let obj_UpdateProfileVM = UpdateUserProfileVM()
    var navigationView = NavigationBarView()
    let dropDown = DropDown()
    let initialData = InitialDataVM()
    var lblPlaceHolder : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_Address.delegate = self
        lblPlaceHolder = UILabel()
        lblPlaceHolder.text = "Address"
        lblPlaceHolder.font = UIFont.systemFont(ofSize: txt_Address.font!.pointSize)
        lblPlaceHolder.sizeToFit()
        txt_Address.addSubview(lblPlaceHolder)
        lblPlaceHolder.frame.origin = CGPoint(x: 5, y: (txt_Address.font?.pointSize)! / 2)
     lblPlaceHolder.textColor = txt_Address.textColor
        lblPlaceHolder.isHidden = !txt_Address.text.isEmpty
     self.txt_Region.delegate = self
     dropDown.anchorView = txt_Region
     initialData.getInitialData(viewController: self)
     var regions:[String] = []
     initialData.bindToController = {
         for i in self.initialData.initialData?.regions ?? [] {
             regions.append(i)
         }
         self.dropDown.dataSource = regions
     }
     dropDown.selectionAction = { (index: Int, item: String) in
         self.txt_Region.text = item
     }
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_Navigation.frame.size.width, height: self.view_Navigation.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.profile.rawValue
        self.navigationView.btn_Profile.isHidden = true
        self.navigationView.btn_Back.addTarget(self, action:#selector( backClicked), for: .touchUpInside)
        view_Navigation.addSubview(navigationView)
        let userId = obj_UserDefault.value(forKey: "userId")
        self.obj_UserProfileVM.getUserProfileApi(viewController: self, userId: userId as! String)
        self.obj_UserProfileVM.bindToController = {
            self.lblPlaceHolder.isHidden = true
            self.txt_Name.text = self.obj_UserProfileVM.userProfileData?.firstName
            self.txt_Last_Name.text = self.obj_UserProfileVM.userProfileData?.lastName
            self.txt_Email.text = self.obj_UserProfileVM.userProfileData?.email
            self.txt_Phone_Number.text = self.obj_UserProfileVM.userProfileData?.mobile
            self.txt_Address.text = self.obj_UserProfileVM.userProfileData?.address
            self.txt_Region.text = self.obj_UserProfileVM.userProfileData?.region
        }
    }
    
    @objc func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {
            if txt_Name.text!.isEmpty {
                Utility().showPositiveMessage(message: "Please enter first name", controller: self)
                return
            }
            if txt_Last_Name.text!.isEmpty {
                Utility().showPositiveMessage(message: "Please enter last name", controller: self)
                return
            }
            if txt_Email.text!.isEmpty {
                Utility().showPositiveMessage(message: "Please enter email", controller: self)
                return
            }
            if !Utility().isValidEmail(testEmail: txt_Email.text) {
                Utility().showPositiveMessage(message: "Please enter a valid email", controller: self)
                return
            }
            if txt_Phone_Number.text!.isEmpty {
                Utility().showPositiveMessage(message: "Please enter phone number", controller: self)
                return
            }
            if txt_Phone_Number.text?.count != 8 {
                Utility().showPositiveMessage(message: "Please enter 8-digit phone number", controller: self)
                return
            }
            if txt_Address.text!.isEmpty {
                Utility().showPositiveMessage(message: "Please give description", controller: self)
                return
            }
            if txt_Region.text!.isEmpty {
                Utility().showPositiveMessage(message: "Please give description", controller: self)
                return
            }
        let dataDict:[String:Any] = ["firstName": self.txt_Name.text ?? "", "lastName": self.txt_Last_Name.text ?? "","email": self.txt_Email.text ?? "","mobile": self.txt_Phone_Number.text ?? "","address":self.txt_Address.text ?? "","region":self.txt_Region.text ?? ""]
        self.obj_UpdateProfileVM.updateProfileApi(viewController: self, param: dataDict, userId: obj_UserDefault.value(forKey: "userId") as! String)
        self.obj_UpdateProfileVM.bindToController = {
            self.obj_UserProfileVM.getUserProfileApi(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String)
            self.obj_UserProfileVM.bindToController = {
                Utility().showPositiveMessage(message: "Profile Update Successfully.", controller: self)
            }
        }
    }
}

extension ProfileViewController : UITextFieldDelegate,UITextViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            dropDown.show()
        return false
    }
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceHolder.isHidden = !textView.text.isEmpty
    }
}


