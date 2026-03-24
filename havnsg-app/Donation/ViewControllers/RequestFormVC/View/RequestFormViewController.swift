//
//  RequestFormViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit
import Photos
import DropDown

class RequestFormViewController: UIViewController {
    
    @IBOutlet weak var view_Category: UIView!
    @IBOutlet weak var view_SubCategory: UIView!
    @IBOutlet weak var txt_Category: UITextField!
    @IBOutlet weak var txt_Description: UITextView!
    @IBOutlet weak var txt_SubCategory: UITextField!
    @IBOutlet weak var txt_Address: UITextView!
    @IBOutlet weak var view_NAvigationBar: UIView!
    @IBOutlet weak var btn_PickUpByReceiver: UIButton!
    @IBOutlet weak var btn_DropOffToReceiver: UIButton!
    @IBOutlet weak var btn_Update_Submit: UIButton!
    @IBOutlet weak var image_PickUpByReceiver: UIImageView!
    @IBOutlet weak var image_DropOffToReceiver: UIImageView!
    
    var category = ""
    var subCategory = ""
    var categoryId = ""
    var subCategoryId = ""
    var requestDescription = ""
    var address = ""
    var screenType = ""
    var requestId = ""
    var userType = ""
    var deliveryType = ""
    var subCategoryName:[String] = []
    var categoryDropDown = DropDown()
    var subCategoryDropDown = DropDown()
    let obj_ReceiveRequest = ReceiveRequestVM()
    let obj_EditReceiveRequest = RequestEditVM()
    var navigationView = NavigationBarView()
    let imagePicker = UIImagePickerController()
    let obj_SubCategoryVM = AdminSubCategoryVM()
    let obj_GetCategoryVM = AdminCategoryVM()
    var isShowNavigationBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_Category.delegate = self
        txt_SubCategory.delegate = self
        self.categoryDropDown.anchorView = self.view_Category
        self.subCategoryDropDown.anchorView = self.view_SubCategory
        self.categoryDropDown.show()
        self.obj_GetCategoryVM.getCategoryApi(viewController: self)
        self.obj_GetCategoryVM.bindToController = {
            var categoryName:[String] = []
            for i in self.obj_GetCategoryVM.categoryData {
                categoryName.append(i.name ?? "")
            }
            self.categoryDropDown.dataSource = categoryName
        }
        categoryDropDown.selectionAction = { (index: Int, item: String) in
            self.txt_Category.text = item
            let categoryId = self.obj_GetCategoryVM.categoryData[index].id
            self.categoryId = categoryId ?? ""
            self.obj_SubCategoryVM.getSubCategoryApi(viewController: self, categoryId: categoryId ?? "")
            self.subCategoryName.removeAll()
            self.obj_SubCategoryVM.bindToController = {
                for i in self.obj_SubCategoryVM.subCategoryData {
                    self.subCategoryName.append(i.name ?? "")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if self.subCategoryName.count != 0 {
                        self.subCategoryDropDown.dataSource = self.subCategoryName
                    } else {
                        self.subCategoryDropDown.dataSource = ["No Sub-Category found"]
                    }
                }
            }
            self.subCategoryDropDown.selectionAction = { (index: Int, item: String) in
                if item != "No Sub-Category found" {
                    self.txt_SubCategory.text = item
                    self.subCategoryId = self.obj_SubCategoryVM.subCategoryData[index].id ?? ""
                } else {
                    self.txt_SubCategory.text = ""
                    self.subCategoryId = ""
                }
            }
        }
        
        setUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.txt_Category.text = ""
//        self.txt_SubCategory.text = ""
//        self.txt_Address.text = ""
//    }
    
    func setUI() {
        if deliveryType.isEmpty {
            deliveryType = "Pickup By Receiver"
        }
        setReceiveType()
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NAvigationBar.frame.size.width, height: self.view_NAvigationBar.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.receivedRequestForReceiver.rawValue
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_NAvigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        Utility().changePlaceholderTetxColor(textField: txt_Category, title: txt_Category.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        Utility().changePlaceholderTetxColor(textField: txt_SubCategory, title: txt_SubCategory.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        //        Utility().changePlaceholderTetxColor(textField: txt_Address, title: txt_Address.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        self.txt_Category.text = self.category
        self.txt_SubCategory.text = self.subCategory
        self.txt_Description.text = self.requestDescription
        let address = obj_UserDefault.value(forKey: "address")
        self.txt_Address.text = address as? String
        if screenType != "" {
            self.btn_Update_Submit.setTitle("Update", for: .normal)
        } else {
            self.btn_Update_Submit.setTitle("Submit", for: .normal)
        }
    }
    
    func setDeliveryType(
        selectedButton: UIButton,
        unselectedButton: UIButton
    ) {
        let themeColor = UIColor(hexString: Colors.themeColor.rawValue)
        let normalColor = UIColor(hexString: Colors.themeColor.rawValue)

        if #available(iOS 13.0, *) {

            let selectedImg = UIImage(systemName: "checkmark.circle.fill")?
                .withTintColor(themeColor, renderingMode: .alwaysOriginal)

            let unselectedImg = UIImage(systemName: "checkmark.circle")?
                .withTintColor(normalColor, renderingMode: .alwaysOriginal)

            selectedButton.setImage(selectedImg, for: .normal)
            unselectedButton.setImage(unselectedImg, for: .normal)
        }
    }

    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setReceiveType() {
        if deliveryType == "Pickup By Receiver" {
            setDeliveryType(
                selectedButton: btn_PickUpByReceiver,
                unselectedButton: btn_DropOffToReceiver
            )
        } else if deliveryType == "Drop off To Receiver" {
            setDeliveryType(
                selectedButton: btn_DropOffToReceiver,
                unselectedButton: btn_PickUpByReceiver
            )
        }
    }


    
    @IBAction func setReceiveType(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            deliveryType = "Pickup By Receiver"
            setReceiveType()

        case 2:
            deliveryType = "Drop off To Receiver"
            setReceiveType()

        default:
            break
        }
    }

    @IBAction func btn_Submit(_ sender: UIButton) {
        if txt_Category.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please select a Category", controller: self)
            return
        }
        if txt_SubCategory.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please select a Sub Category", controller: self)
            return
        }
        if txt_Description.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please give description", controller: self)
            return
        }
        if deliveryType == "" {
            Utility().showPositiveMessage(message: "Please select a delivery type" , controller: self)
            return
        }
        let region = obj_UserDefault.value(forKey: "region") as! String
        let dataDict:[String:Any] = ["categoryId": self.categoryId,"subcategoryId":self.subCategoryId,"description":self.txt_Description.text ?? "","region":region,"address":self.txt_Address.text ?? "","deliveryType":"Drop off To Receiver"]
        if screenType == "" || screenType == "Subcategory" {
            self.obj_ReceiveRequest.receiveRequestApi(viewController: self, param: dataDict)
            self.obj_ReceiveRequest.bindToController = {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else {
            self.obj_EditReceiveRequest.RequestEditApi(viewController: self, param: dataDict, requestId: self.requestId)
            self.obj_EditReceiveRequest.bindToController = {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}

extension RequestFormViewController:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txt_Category {
            categoryDropDown.show()
        } else {
            subCategoryDropDown.show()
        }
        return false
    }
}

