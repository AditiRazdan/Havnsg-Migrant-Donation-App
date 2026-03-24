//
//  AddSubCategoryViewController.swift
//  Donation
//
//  Created by user922181 on 9/26/21.
//

import UIKit
import DropDown

class AddSubCategoryViewController: UIViewController {
    @IBOutlet weak var view_NavigationBar: UIView!
    @IBOutlet weak var txt_Category: UITextField!
    @IBOutlet weak var txt_Sub_Category: UITextField!
    @IBOutlet weak var btn_Submit: UIButton!
    @IBOutlet weak var img_AddImage: UIImageView!
    @IBOutlet weak var img_UpoadImage: UIImageView!
    @IBOutlet weak var view_Category: UIView!
    let imagePicker = UIImagePickerController()
    var navigationView = NavigationBarView()
    let obj_addSubCat = AddSubCategoryVM()
    let obj_UpdateSubCategoryVM = UpdateSubCategoryVM()
    let obj_getAllCategoryVM = AdminCategoryVM()
    //    var catData : AdminCategoryDatum?
    var screenType = ""
    var imageData:Data?
    var categoryDropDown = DropDown()
    var categoryId = ""
    var subCategoryId = ""
    var categoryName = ""
    var subCategoryName = ""
    var isShowNavigationBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_Category.delegate = self
        self.categoryDropDown.anchorView = self.view_Category
        self.categoryDropDown.show()
        self.obj_getAllCategoryVM.getCategoryApi(viewController: self)
        self.obj_getAllCategoryVM.bindToController = {
            var categoryName:[String] = []
            for i in self.obj_getAllCategoryVM.categoryData {
                categoryName.append(i.name ?? "")
            }
            self.categoryDropDown.dataSource = categoryName
        }
        self.categoryDropDown.selectionAction = { (index: Int, item: String) in
            self.txt_Category.text = item
            self.categoryId = self.obj_getAllCategoryVM.categoryData[index].id ?? ""
        }
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.addSubCategory.rawValue
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_NavigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        Utility().changePlaceholderTetxColor(textField: txt_Category, title: "Category", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        Utility().changePlaceholderTetxColor(textField: txt_Sub_Category, title: "SubCategory", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        if screenType != "" {
            btn_Submit.setTitle("Update", for: .normal)
        } else {
            btn_Submit.setTitle("Submit", for: .normal)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.btn_Upload_Image(_:)))
        img_AddImage.addGestureRecognizer(tap)
        img_AddImage.isUserInteractionEnabled = true
        img_UpoadImage.addGestureRecognizer(tap)
        img_UpoadImage.isUserInteractionEnabled = true
        self.setUI()
    }
    
    func setUI() {
        self.txt_Category.text = self.categoryName
        self.txt_Sub_Category.text = self.subCategoryName
    }
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func BtnClicked_submit(_ sender: Any) {
        if txt_Sub_Category.text == "" {
            Utility().showPositiveMessage(message: "Please enter Sub Category", controller: self)
            return;
        }
        let dataDict:[String:Any] = ["name" : txt_Sub_Category.text ?? "","parentCategory":self.categoryId,"categoryImage":self.imageData as Any]
        let formData = NSMutableArray()
        formData.add(dataDict)
        if screenType == "" {
            self.obj_addSubCat.AddSubCategoryAPI(viewController: self, param: dataDict, formdata: formData, url: ApiEndpoints.addSubCategory)
            self.obj_addSubCat.bindToController = {
                Utility().showPositiveMessage(message: "Subcategory added successfully.", controller: self)
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.obj_addSubCat.AddSubCategoryAPI(viewController: self, param: dataDict, formdata: formData, url: ApiEndpoints.updateSubcategory + subCategoryId)
            self.obj_addSubCat.bindToController = {
                Utility().showPositiveMessage(message: "Subcategory updated successfully.", controller: self)
                self.navigationController?.popViewController(animated: true)
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
}
extension AddSubCategoryViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        img_UpoadImage.image  = tempImage
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
            print("hello")
        }
        return false
    }
}
