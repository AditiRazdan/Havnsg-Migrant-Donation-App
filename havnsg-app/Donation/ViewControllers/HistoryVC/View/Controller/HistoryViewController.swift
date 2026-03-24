//
//  DonationRequestViewController.swift
//  Donation
//
//  Created by user922181 on 10/2/21.
//

import UIKit
import CarbonKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var view_NavigationBar: UIView!
//    @IBOutlet weak var tbl_DonationRequest: UITableView!
    @IBOutlet weak var view_CarbonKitController: UIView!
    var navigationView = NavigationBarView()
    let obj_GetAllDonationHistory = AllDonationHistoryForDonerVM()
    let obj_GetAllReceiveHistory = AllReceiveHistoryForReceiverVM()
    let obj_GetAllReceiveHistoryForVolunteer = AllReceiveHistoryForVolunteerVM()
    let obj_GetAllDonationHistoryForVolunteer = AllDonationHistoryForVolunteerVM()
    let obj_GetAllReceiveHistoryForAdmin = AllReceiveHistoryForAdminVM()
    let obj_GetAllDonationHistoryForAdmin = AllDonationHistoryForAdminVM()
    var userType:String = ""
    var screenType = ""
    var isShowNavigationBar = false
    var items = ["Matched","Pending","Completed"]
    var carbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    override func viewDidLoad() {
        super.viewDidLoad()
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width / 3,forSegmentAt:0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width / 3,forSegmentAt:1)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(view.frame.width / 3,forSegmentAt:2)
        carbonTabSwipeNavigation.setTabBarHeight(40)
        carbonTabSwipeNavigation.setNormalColor(.black)
        carbonTabSwipeNavigation.setSelectedColor(UIColor.init(hexString: Colors.themeColor.rawValue))
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.init(hexString: Colors.themeColor.rawValue))

//        carbonTabSwipeNavigation.setSelectedColor(Colors.AppBlueColor)
//        carbonTabSwipeNavigation.setIndicatorColor(Colors.AppBlueColor)
        self.carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: self.view_CarbonKitController)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI() {
//        self.tbl_DonationRequest.register(UINib(nibName: "DonationRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationRequestTableViewCell")
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_NavigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        userType = obj_UserDefault.value(forKey: "userType") as! String
        if userType == "doner" {
            self.navigationView.lbl_Title.text = PageTite.historyForDoner.rawValue
//            self.obj_GetAllDonationHistory.getDonationHistory(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String)
            self.obj_GetAllDonationHistory.bindToController = {
//                self.tbl_DonationRequest.reloadData()
            }
        } else if userType == "receiver"{
            self.navigationView.lbl_Title.text = PageTite.historyForReceiver.rawValue
            self.obj_GetAllReceiveHistory.getReceiveHistory(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String)
            self.obj_GetAllReceiveHistory.bindToController = {
//                self.tbl_DonationRequest.reloadData()
            }
        } else if userType == "volunteer"{
            if self.screenType == "donation"{
                self.navigationView.lbl_Title.text = "Donation Request"
                self.obj_GetAllDonationHistoryForVolunteer.getAllDonationHistoryByRegion(viewController: self, region: "Central Region")
                self.obj_GetAllDonationHistoryForVolunteer.bindToController = {
//                    self.tbl_DonationRequest.reloadData()
                }
            } else if self.screenType == "receive"{
                self.navigationView.lbl_Title.text = "Receive Request"
                self.obj_GetAllReceiveHistoryForVolunteer.getallReceiveHistoryByRegion(viewController: self, region: "Central Region")
                self.obj_GetAllReceiveHistoryForVolunteer.bindToController = {
//                    self.tbl_DonationRequest.reloadData()
                }
            }
        } else {
            self.navigationView.lbl_Title.text = "Receive Request"
            self.obj_GetAllReceiveHistory.getReceiveHistory(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String)
            self.obj_GetAllReceiveHistory.bindToController = {
//                self.tbl_DonationRequest.reloadData()
            }
        }
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HistoryViewController: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
//        guard let storyboard = storyboard else{ return UIViewController()}
        if index == 0 {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "TransactionStatusViewController") as! TransactionStatusViewController
            nextVC.userType = self.userType
            nextVC.screenType = self.screenType
            nextVC.status = "matched"
            return nextVC
        } else if index == 1 {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier:"TransactionStatusViewController") as! TransactionStatusViewController
            nextVC.userType = self.userType
            nextVC.screenType = self.screenType
            nextVC.status = "pending"
            return nextVC
        }
        else  {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier:"TransactionStatusViewController")as! TransactionStatusViewController
            nextVC.userType = self.userType
            nextVC.screenType = self.screenType
            nextVC.status = "completed"
            return nextVC
        }
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if userType == "doner" {
//            return self.obj_GetAllDonationHistory.allDonationaHistoryData.count
//        } else if userType == "receiver" {
//            return self.obj_GetAllReceiveHistory.allReceiveHistoryData.count
//        } else if userType == "volunteer" {
//            if screenType == "donation" {
//                return self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData.count
//            } else if screenType == "receive" {
//                return self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData.count
//            } else {
//                return 0
//            }
//        } else {
//            if screenType == "donation" {
//                return self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData.count
//            } else if screenType == "receive" {
//                return self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData.count
//            }  else {
//                return 0
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationRequestTableViewCell", for: indexPath) as! DonationRequestTableViewCell
//        if userType == "doner" {
//            cell.lbl_Date.text = self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].cretedAt ?? ""
//            cell.lbl_CategoryName.text = (self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].subCategoryName ?? "")
//            let status = obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].status ?? ""
//            if status == "Completed" {
//                cell.img_Status.image = UIImage(named: "Success")
//            } else if status == "Pending" {
//                cell.img_Status.image = UIImage(named: "14")
//            } else {
//                cell.img_Status.image = UIImage(named: "14")
//            }
//            cell.selectionStyle = .none
//            return cell
//
//        } else if userType == "receiver" {
//            cell.lbl_Date.text = self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].cretedAt ?? ""
//            cell.lbl_CategoryName.text = (self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].subCategoryName ?? "")
//            let status = obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].status ?? ""
//            if status == "Completed" {
//                cell.img_Status.image = UIImage(named: "Success")
//            } else if status == "Pending" {
//                cell.img_Status.image = UIImage(named: "14")
//            } else {
//                cell.img_Status.image = UIImage(named: "14")
//            }
//            cell.selectionStyle = .none
//            return cell
//        } else if userType == "volunteer"{
//            if screenType == "donation" {
//                cell.lbl_Date.text = self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].cretedAt ?? ""
//                cell.lbl_CategoryName.text = (self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].subCategoryName ?? "")
//                let status = obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].status ?? ""
//                if status == "Completed" {
//                    cell.img_Status.image = UIImage(named: "Success")
//                } else if status == "Pending" {
//                    cell.img_Status.image = UIImage(named: "14")
//                } else {
//                    cell.img_Status.image = UIImage(named: "14")
//                }
//                cell.selectionStyle = .none
//                return cell
//            } else if screenType == "receive" {
//                cell.lbl_Date.text = self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].cretedAt ?? ""
//                cell.lbl_CategoryName.text = (self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].subCategoryName ?? "")
//                let status = obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].status ?? ""
//                if status == "Completed" {
//                    cell.img_Status.image = UIImage(named: "Success")
//                } else if status == "Pending" {
//                    cell.img_Status.image = UIImage(named: "14")
//                }else {
//                    cell.img_Status.image = UIImage(named: "14")
//                }
//                cell.selectionStyle = .none
//                return cell
//            } else {
//                return cell
//            }
//        } else {
//            if screenType == "donation" {
//                cell.lbl_Date.text = self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].cretedAt ?? ""
//                cell.lbl_CategoryName.text = (self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].subCategoryName ?? "")
//                let status = obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].status ?? ""
//                if status == "Completed" {
//                    cell.img_Status.image = UIImage(named: "Success")
//                } else if status == "Pending" {
//                    cell.img_Status.image = UIImage(named: "14")
//                } else {
//                    cell.img_Status.image = UIImage(named: "14")
//                }
//                cell.selectionStyle = .none
//                return cell
//            } else if screenType == "receive" {
//                cell.lbl_Date.text = self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].cretedAt ?? ""
//                cell.lbl_CategoryName.text = (self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].subCategoryName ?? "")
//                let status = obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].status ?? ""
//                if status == "Completed" {
//                    cell.img_Status.image = UIImage(named: "Success")
//                } else if status == "Pending" {
//                    cell.img_Status.image = UIImage(named: "14")
//                } else {
//                    cell.img_Status.image = UIImage(named: "14")
//                }
//                cell.selectionStyle = .none
//                return cell
//            } else {
//                return cell
//            }
//        }
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if userType == "doner" {
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//            nextVC.requestId = self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].id ?? ""
//            nextVC.userType = "doner"
//            nextVC.isShowNavigationBar = true
//            self.navigationController?.pushViewController(nextVC, animated: true)
//
//        } else if userType == "receiver" {
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//            nextVC.requestId = self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].id ?? ""
//            nextVC.userType = "receiver"
//            nextVC.isShowNavigationBar = true
//            self.navigationController?.pushViewController(nextVC, animated: true)
//        } else if userType == "volunteer" {
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//            nextVC.userType = "volunteer"
//            if screenType == "donation" {
//                nextVC.requestId = self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].id ?? ""
//                nextVC.screenType = "donation"
//                nextVC.isShowNavigationBar = true
//            } else if screenType == "receive" {
//                nextVC.requestId = self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].id ?? ""
//                nextVC.screenType = "receive"
//                nextVC.isShowNavigationBar = true
//            }
//            self.navigationController?.pushViewController(nextVC, animated: true)
//
//        } else {
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//            nextVC.userType = "admin"
//            if screenType == "donation" {
//                nextVC.requestId = self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].id ?? ""
//                nextVC.screenType = "donation"
//                nextVC.isShowNavigationBar = true
//            } else if screenType == "receive" {
//                nextVC.requestId = self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].id ?? ""
//                nextVC.screenType = "receive"
//                nextVC.isShowNavigationBar = true
//            }
//            self.navigationController?.pushViewController(nextVC, animated: true)
//
//        }
//    }
}

