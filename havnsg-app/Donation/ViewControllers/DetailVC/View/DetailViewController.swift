//
//  DonationDetailViewController.swift
//  Donation
//
//  Created by user922181 on 10/2/21.
//

import UIKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var view_NavigationBar: UIView!
    @IBOutlet weak var lbl_Category: UILabel!
    @IBOutlet weak var lbl_SubCategory: UILabel!
    @IBOutlet weak var lbl_Description: UILabel!
    @IBOutlet weak var lbl_PickUpByReciever: UILabel!
    @IBOutlet weak var lbl_Address: UILabel!
    @IBOutlet weak var lbl_Region: UILabel!
    @IBOutlet weak var lbl_Delete: UILabel!
    @IBOutlet weak var btn_AcceptRequest: UIButton!
    @IBOutlet weak var btn_Status : UIButton!
    @IBOutlet weak var btn_Delete : UIButton!
    @IBOutlet weak var img_RequestDetailImage: UIImageView!
    var navigationView = NavigationBarView()
    var requestId = ""
    var screenType = ""
    var userType = ""
    var isEditable = true
    var isPendingRequest = false
    let obj_DeleteRequestVM = DonationDeleteVM()
    let obj_DonationRequestDetailVM  = DonationRequestDetailVM()
    let obj_ChangeDonationStatus = ChangeDonationRequestStatusVM()
    let obj_DeleteReceiveRequestVM = ReceiveRequestDeleteVM()
    let obj_ReceiveRequestDetailVM = ReceiveRequestDetailVM()
    let obj_ChangeReceiveStatus = ChangeReceiveRequestStatusVM()
    let obj_AcceptRequestVM = AcceptRequestVM()
    var isShowNavigationBar = false
    var isShowMatchedDetailsButton = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI () {
        if self.isShowMatchedDetailsButton {
            self.btn_AcceptRequest.isHidden = false
            self.btn_AcceptRequest.setTitle("See Matched Detail", for: .normal)
        } else {
            if userType == "doner" {
                self.btn_AcceptRequest.setTitle(AcceptRequestButtonTitle.forDoner.rawValue, for: .normal)
            } else {
                self.btn_AcceptRequest.setTitle(AcceptRequestButtonTitle.forReceiver.rawValue, for: .normal)
            }
        }
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_NavigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile(_:)), for: .touchUpInside)
        if screenType != "" {
            btn_AcceptRequest.isHidden = false
        }
        if userType == "doner" {
            if isPendingRequest {
                self.btn_Delete.isHidden = true
                self.lbl_Delete.isHidden = true
                self.obj_ReceiveRequestDetailVM.getRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_ReceiveRequestDetailVM.bindToController = {
                    self.navigationView.lbl_Title.text = (self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? "") + "/" + (self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Category.text = "Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_ReceiveRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_ReceiveRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    } else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            } else {
                self.btn_Delete.isHidden = true
                self.lbl_Delete.isHidden = true
                self.obj_DonationRequestDetailVM.getDonationRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_DonationRequestDetailVM.bindToController = {
                    self.navigationView.lbl_Title.text = (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "") + "/" + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Category.text = "Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_DonationRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_DonationRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_DonationRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_DonationRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_DonationRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    }  else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
//                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            }
        } else if userType == "receiver" {
            if isPendingRequest {
                self.btn_Delete.isHidden = true
                self.lbl_Delete.isHidden = true
                self.obj_DonationRequestDetailVM.getDonationRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_DonationRequestDetailVM.bindToController = {
                    self.navigationView.lbl_Title.text = (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "") + "/" + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Category.text = "Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_DonationRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_DonationRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_DonationRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_DonationRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_DonationRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    }  else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            } else {
                self.btn_Delete.isHidden = true
                self.lbl_Delete.isHidden = true
                self.obj_ReceiveRequestDetailVM.getRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_ReceiveRequestDetailVM.bindToController = {
                    self.navigationView.lbl_Title.text = (self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? "") + "/" + (self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Category.text = "Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_ReceiveRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    }
                }
            }
        } else if userType == "volunteer" {
            self.btn_Delete.isHidden = true
            self.lbl_Delete.isHidden = true
            self.btn_AcceptRequest.isHidden = true
            if screenType == "donation"{
                self.obj_DonationRequestDetailVM.getDonationRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_DonationRequestDetailVM.bindToController = {
                    self.lbl_Category.text = "Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_DonationRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_DonationRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_DonationRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_DonationRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_DonationRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    } else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            } else if screenType == "receive" {
                self.obj_ReceiveRequestDetailVM.getRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_ReceiveRequestDetailVM.bindToController = {
                    self.lbl_Category.text = "Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_ReceiveRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    } else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            }
        } else {
            self.btn_AcceptRequest.isHidden = true
            if screenType == "donation"{
                self.obj_DonationRequestDetailVM.getDonationRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_DonationRequestDetailVM.bindToController = {
                    self.lbl_Category.text = "Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_DonationRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_DonationRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_DonationRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_DonationRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_DonationRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    }else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            } else if screenType == "receive"{
                self.obj_ReceiveRequestDetailVM.getRequestDetailApi(viewController: self, requestId: self.requestId)
                self.obj_ReceiveRequestDetailVM.bindToController = {
                    self.lbl_Category.text = "Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? "")
                    self.lbl_SubCategory.text = "Sub Category - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? "")
                    self.lbl_Address.text = "Address - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.address ?? "")
                    self.lbl_Region.text = "Region - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.region ?? "")
                    self.lbl_Description.text = "Description - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.description ?? "")
                    self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_ReceiveRequestDetailVM.requestDetails?.deliveryType ?? "")
                    let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                    let imageUrl = IMAGE_URL + Url
                    if Url == ""{
                        self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                    }else {
                        self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                    }
                    let status = self.obj_ReceiveRequestDetailVM.requestDetails?.status ?? ""
                    if status == "Completed" {
                        self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    } else if status == "Pending" {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                    }
                    else {
                        self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        self.btn_AcceptRequest.isHidden = true
                    }
                }
            } else {
                if screenType == "donation"{
                    self.obj_DonationRequestDetailVM.getDonationRequestDetailApi(viewController: self, requestId: self.requestId)
                    self.obj_DonationRequestDetailVM.bindToController = {
                        self.lbl_Category.text = "Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? "")
                        self.lbl_SubCategory.text = "Sub Category - " + (self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? "")
                        self.lbl_Address.text = "Address - " + (self.obj_DonationRequestDetailVM.requestDetails?.address ?? "")
                        self.lbl_Region.text = "Region - " + (self.obj_DonationRequestDetailVM.requestDetails?.region ?? "")
                        self.lbl_Description.text = "Description - " + (self.obj_DonationRequestDetailVM.requestDetails?.description ?? "")
                        self.lbl_PickUpByReciever.text = "Delivery Type - " + (self.obj_DonationRequestDetailVM.requestDetails?.deliveryType ?? "")
                        let Url = self.obj_DonationRequestDetailVM.requestDetails?.image ?? ""
                        let imageUrl = IMAGE_URL + Url
                        if Url == ""{
                            self.img_RequestDetailImage.image = UIImage(named: "asset-193")
                        }else {
                            self.img_RequestDetailImage.setImage(url: imageUrl, placeholder: nil)
                        }
                        let status = self.obj_DonationRequestDetailVM.requestDetails?.status ?? ""
                        if status == "Completed" {
                            self.btn_Status.setImage(UIImage(named: "Success"), for: .normal)
                            self.btn_AcceptRequest.isHidden = true
                        } else if status == "Pending" {
                            self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                        }else {
                            self.btn_Status.setImage(UIImage(named: "14"), for: .normal)
                            self.btn_AcceptRequest.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    func setData(donorObj:DonationRequestDetailVM,receiverObj:ReceiveRequestDetailVM) {
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showAlert(title:String,message:String,button1Title:String,status1: String,button2Title:String,status2:String) {
        let alertController = UIAlertController(title: "Change Status", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: button1Title, style: .default) { _ in
            if self.userType == "doner" {
                self.obj_ChangeDonationStatus.ChangeDonationRequestStatus(viewController: self, param: ["status":status1], requestId: self.requestId)
                self.obj_ChangeDonationStatus.bindToController = {
                    self.navigationController?.popViewController(animated: true)
                }
            } else if self.userType == "receiver" {
                self.obj_ChangeReceiveStatus.ChangeReceiveRequestStatus(viewController: self, param: ["status":status1], requestId: self.requestId)
                self.obj_ChangeReceiveStatus.bindToController = {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        let acceptAction = UIAlertAction(title: button2Title, style: .default) { _ in
            if self.userType == "doner"{
                self.obj_ChangeDonationStatus.ChangeDonationRequestStatus(viewController: self, param: ["status":status2], requestId: self.requestId)
                self.obj_ChangeDonationStatus.bindToController = {
                    self.navigationController?.popViewController(animated: true)
                }
            } else if self.userType == "receiver" {
                self.obj_ChangeReceiveStatus.ChangeReceiveRequestStatus(viewController: self, param: ["status":status2], requestId: self.requestId)
                self.obj_ChangeReceiveStatus.bindToController = {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(okAction)
        if status2 == "Completed" {
            alertController.addAction(acceptAction)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btn_Status_Cicked(_ sender: UIButton) {
        var status = ""
        if userType == "doner" {
            status = self.obj_DonationRequestDetailVM.requestDetails?.status ?? ""
        } else if userType == "receiver" {
            status = self.obj_ReceiveRequestDetailVM.requestDetails?.status ?? ""
        }
        switch status {
            //        case "Pending":
            //            showAlert(title: "Change Status", message: "Please select accept to accept the donation.", button1Title: "Accept", status1: "Matched", button2Title: "", status2: "")
        case "Matched":
            showAlert(title: "Change Status", message: "Please select reject to reject and completed to complete the donation.", button1Title: "Reject", status1: "Pending", button2Title: "Completed", status2: "Completed")
        default :
            print("completed")
        }
    }
    @IBAction func btn_Delete_Clicked(_ sender: UIButton) {
        if userType == "doner" {
            self.obj_DeleteRequestVM.deleteDonationRequestApi(viewController: self, requestId: self.requestId)
            self.obj_DeleteRequestVM.bindToController = {
                self.navigationController?.popViewController(animated: true)
            }
        } else if userType == "receiver" {
            self.obj_DeleteReceiveRequestVM.deleteReceiveRequestApi(viewController: self, requestId: self.requestId)
            self.obj_DeleteReceiveRequestVM.bindToController = {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    @IBAction func btn_Edit_Clicked(_ sender: UIButton) {
        if isEditable {
            if userType == "receiver" {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestFormViewController") as! RequestFormViewController
                nextVC.category = self.obj_ReceiveRequestDetailVM.requestDetails?.categoryName ?? ""
                nextVC.subCategory = self.obj_ReceiveRequestDetailVM.requestDetails?.subCategoryName ?? ""
                nextVC.address = self.obj_ReceiveRequestDetailVM.requestDetails?.address ?? ""
                nextVC.categoryId = self.obj_ReceiveRequestDetailVM.requestDetails?.categoryId ?? ""
                nextVC.subCategoryId = self.obj_ReceiveRequestDetailVM.requestDetails?.subcategoryId ?? ""
                nextVC.requestDescription = self.obj_ReceiveRequestDetailVM.requestDetails?.description ?? ""
                nextVC.screenType = "Update"
                nextVC.requestId = self.obj_ReceiveRequestDetailVM.requestDetails?._id ?? ""
                nextVC.deliveryType = self.obj_ReceiveRequestDetailVM.requestDetails?.deliveryType ?? ""
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else if userType == "doner" {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DonationViewController") as! DonationViewController
                nextVC.category = self.obj_DonationRequestDetailVM.requestDetails?.categoryName ?? ""
                nextVC.subCategory = self.obj_DonationRequestDetailVM.requestDetails?.subCategoryName ?? ""
                nextVC.address = self.obj_DonationRequestDetailVM.requestDetails?.address ?? ""
                nextVC.categoryId = self.obj_DonationRequestDetailVM.requestDetails?.categoryId ?? ""
                nextVC.subCategoryId = self.obj_DonationRequestDetailVM.requestDetails?.subcategoryId ?? ""
                nextVC.rquestDescription = self.obj_DonationRequestDetailVM.requestDetails?.description ?? ""
                nextVC.requestId = self.obj_DonationRequestDetailVM.requestDetails?._id ?? ""
                nextVC.screenType = "Update"
                nextVC.deliveryType = self.obj_DonationRequestDetailVM.requestDetails?.deliveryType ?? ""
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else {
            Utility().showPositiveMessage(message: "You can't edit other requests.", controller: self)
        }
    }
    
    @IBAction func btn_AcceptRequest(_ sender: UIButton) {
        if self.isShowMatchedDetailsButton {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MatchedDetailViewController") as! MatchedDetailViewController
            nextVC.requestId = self.requestId
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            if userType == "doner" {
                var url = ""
                url = "request/accept/donation" + "/" + (self.requestId)
                self.obj_AcceptRequestVM.acceptRequest(viewController: self, url: url)
            } else if userType == "receiver" {
                var url = ""
                url = "request/accept/receive" + "/" + (self.requestId)
                self.obj_AcceptRequestVM.acceptRequest(viewController: self, url: url)
            }
            self.obj_AcceptRequestVM.bindToController = {
                //        Utility().showPositiveMessage(message: "Request accepted.", controller: self)
                let alertController = UIAlertController(title: "", message: "Request accepted.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MatchedDetailViewController") as! MatchedDetailViewController
                    nextVC.requestId = self.requestId
                    nextVC.isShowLabel = true
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
