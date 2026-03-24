//
//  DonationViewController.swift
//  Donation
//
//  Created by user922181 on 10/2/21.
//

import UIKit
import Photos
import DropDown

class DonationViewController: UIViewController {
    
    @IBOutlet weak var view_NavigationBar: UIView!
    @IBOutlet weak var view_Category: UIView!
    @IBOutlet weak var view_SubCategory: UIView!
    @IBOutlet weak var txt_Category: UITextField!
    @IBOutlet weak var txt_SubCategory: UITextField!
    @IBOutlet weak var txt_Description: UITextView!
    @IBOutlet weak var txt_Address: UITextView!
    @IBOutlet weak var image_PickUpByReceiver: UIImageView!
    @IBOutlet weak var image_DropOffToReceiver: UIImageView!
    @IBOutlet weak var img_AddImage: UIImageView!
    @IBOutlet weak var img_Upload: UIImageView!
    
    var navigationView = NavigationBarView()
    var category = ""
    var subCategory = ""
    var categoryId = ""
    var subCategoryId = ""
    var rquestDescription = ""
    var region = ""
    var address = ""
    var userType = ""
    var screenType = ""
    var requestId = ""
    var deliveryType = ""
    var subCategoryName:[String] = []
    var imageData:Data?
    var categoryDropDown = DropDown()
    var subCategoryDropDown = DropDown()
    let imagePicker = UIImagePickerController()
    let obj_DonateRequestVM = DonateRequestVM()
    let obj_SubCategoryVM = AdminSubCategoryVM()
    let obj_GetCategoryVM = AdminCategoryVM()
    let obj_DonateEdit = DonationRequestEditVM()
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
            self.obj_SubCategoryVM.getSubCategoryApi(viewController: self, categoryId: categoryId ?? "")
            self.categoryId = categoryId ?? ""
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
    
    override func viewWillAppear(_ animated: Bool) {
        if self.screenType != "Update"{
            self.txt_Description.text = ""
            setReceiveType()
        }
    }
    func setUI() {
        setReceiveType()
        let address = obj_UserDefault.value(forKey: "address")
        self.txt_Address.text = address as? String
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.btn_Upload_Image(_:)))
        img_AddImage.addGestureRecognizer(tap)
        img_AddImage.isUserInteractionEnabled = true
        img_Upload.addGestureRecognizer(tap)
        img_Upload.isUserInteractionEnabled = true
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.createDonationRequestForDoner.rawValue
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_NavigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        Utility().changePlaceholderTetxColor(textField: txt_Category, title: txt_Category.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        Utility().changePlaceholderTetxColor(textField: txt_SubCategory, title: txt_SubCategory.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        print("Category is \(self.category)")
        print("Sub-Category is \(self.subCategory)")
        self.txt_Category.text = self.category
        self.txt_SubCategory.text = self.subCategory 
        print("user address is \(self.address)")
        self.txt_Description.text = self.rquestDescription
    }
    
    func checkValidation() -> Bool {
        if txt_Category.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please select a Category", controller: self)
            return false
        }
        else if txt_SubCategory.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please select a Sub Category", controller: self)
            return false
        }
        else if txt_Description.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please give description", controller: self)
            return false
        }
        else if imageData == nil {
            Utility().showPositiveMessage(message: "Please select an image", controller: self)
            return false
        }
        else if deliveryType == "" {
            Utility().showPositiveMessage(message: "Please select a delivery type", controller: self)
            return false
        }
        else if txt_Address.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please Enter address", controller: self)
            return false
        }
        else {
            return true
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setDeliveryType(selectedImage : UIImageView, unselectedImageView: UIImageView) {
        if #available(iOS 13.0, *) {
            selectedImage.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            unselectedImageView.image = UIImage(systemName: "checkmark.circle")
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func btn_Submit(_ sender: UIButton) {
        if checkValidation() {
            let region = obj_UserDefault.value(forKey: "region") as! String
            let dataDict:[String:Any] = ["categoryId": self.categoryId,"subcategoryId":self.subCategoryId,"description":self.txt_Description.text ?? "","region":region,"address":self.txt_Address.text ?? "","image":imageData as Any,"deliveryType":"Drop off To Receiver"]
            let formData = NSMutableArray()
            formData.add(dataDict)
            if screenType == "" {
                self.obj_DonateRequestVM.sendFormDataApi(viewController: self, param: dataDict,formdata: formData,url: "donate")
                self.obj_DonateRequestVM.bindToController = {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                    nextVC.isShowNavigationBar = true
//                    Utility().showPositiveMessage(message: "Donation Offer Submitted Successfully", controller: self)
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            } else {
//                let userType = obj_UserDefault.value(forKey: "userType") as! String
//                var url = ""
//                if userType == "doner" {
//                     url = "request/accept/donation" + "/" + (self.requestId)
//                } else if userType == "receiver" {
//                    url = "request/accept/receive" + "/" + (self.requestId)
//                }
//                self.obj_AcceptRequestVM.acceptRequest(viewController: self, url: url)
                self.obj_DonateEdit.editSendFormDataApi(viewController: self, param: dataDict, formdata: formData, url: self.requestId)
                self.obj_DonateEdit.bindToController = {
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                    nextVC.isShowNavigationBar = true
//                    Utility().showPositiveMessage(message: "Donation Offer Updated Successfully", controller: self)
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
    }
    @objc func btn_Upload_Image(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "", message: "Choose your options", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
                print("The device has camera")
            }
            else {
                print("The device has no camera")
            }
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
                print("The device has gallery")
            }
            else {
                print("The device has no gallery")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    func setReceiveType() {
        if screenType == "Update" {
            if deliveryType == "Pickup By Receiver" {
                setDeliveryType(selectedImage: image_PickUpByReceiver, unselectedImageView: image_DropOffToReceiver)
            } else if deliveryType == "Drop off To Receiver" {
                setDeliveryType(selectedImage: image_DropOffToReceiver, unselectedImageView: image_PickUpByReceiver)
            }
        }
    }
    
    @IBAction func setReceiveType(_ sender: UIButton) {
        switch sender.tag {
        case 1 :
            deliveryType = "Pickup By Receiver"
            setDeliveryType(selectedImage: image_PickUpByReceiver, unselectedImageView: image_DropOffToReceiver)
            break
        case 2 :
            deliveryType = "Drop off To Receiver"
            setDeliveryType(selectedImage: image_DropOffToReceiver, unselectedImageView: image_PickUpByReceiver)
            break
        default:
            print("Invalid")
        }
    }
}

extension DonationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        img_Upload.isHidden = false
        img_Upload.image  = tempImage
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageData = selectedImage.jpegData(compressionQuality: 0.6)
        }
        else
        {
            print("Something went wrong")
        }
        self.dismiss(animated: true) {
            self.img_AddImage.isHidden = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txt_Category {
            categoryDropDown.show()
        } else {
            subCategoryDropDown.show()
        }
        return false
    }
}


