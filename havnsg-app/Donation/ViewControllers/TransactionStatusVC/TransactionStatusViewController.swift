//
//  TransactionStatusViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 14/01/22.
//

import UIKit

class TransactionStatusViewController: UIViewController {

    @IBOutlet weak var tbl_TransactionStatus: UITableView!
    var userType:String = ""
    var screenType:String = ""
    var status:String = ""
    var isShowDetailsButton = false
    let obj_GetAllDonationHistory = AllDonationHistoryForDonerVM()
    let obj_GetAllReceiveHistory = AllReceiveHistoryForReceiverVM()
    let obj_GetAllReceiveHistoryForVolunteer = AllReceiveHistoryForVolunteerVM()
    let obj_GetAllDonationHistoryForVolunteer = AllDonationHistoryForVolunteerVM()
    let obj_GetAllReceiveHistoryForAdmin = AllReceiveHistoryForAdminVM()
    let obj_GetAllDonationHistoryForAdmin = AllDonationHistoryForAdminVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_TransactionStatus.register(UINib(nibName: "DonationRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationRequestTableViewCell")
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUI()			
    }
    func setUI() {
        if self.status == "matched" {
            self.isShowDetailsButton = true
        }
        self.tbl_TransactionStatus.register(UINib(nibName: "DonationRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationRequestTableViewCell")
        userType = obj_UserDefault.value(forKey: "userType") as! String
        if userType == "doner" {
            self.obj_GetAllDonationHistory.getDonationHistory(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String, status: self.status)
            self.obj_GetAllDonationHistory.bindToController = {
                print(self.obj_GetAllDonationHistory.allDonationaHistoryData.count)
                self.tbl_TransactionStatus.reloadData()
            }
        } else if userType == "receiver"{
            self.obj_GetAllReceiveHistory.getReceiveHistoryByStatus(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String, status: self.status)
            self.obj_GetAllReceiveHistory.bindToController = {
                self.tbl_TransactionStatus.reloadData()
            }
        } else if userType == "volunteer"{
            if self.screenType == "donation"{
                self.obj_GetAllDonationHistoryForVolunteer.getAllDonationHistoryByRegion(viewController: self, region: "Central Region")
                self.obj_GetAllDonationHistoryForVolunteer.bindToController = {
                    self.tbl_TransactionStatus.reloadData()
                }
            } else if self.screenType == "receive"{
                self.obj_GetAllReceiveHistoryForVolunteer.getallReceiveHistoryByRegion(viewController: self, region: "Central Region")
                self.obj_GetAllReceiveHistoryForVolunteer.bindToController = {
                    self.tbl_TransactionStatus.reloadData()
                }
            }
        } else {
            self.obj_GetAllReceiveHistory.getReceiveHistoryByStatus(viewController: self, userId: obj_UserDefault.value(forKey: "userId") as! String, status: self.status)
            self.obj_GetAllReceiveHistory.bindToController = {
                self.tbl_TransactionStatus.reloadData()
            }
        }
    }
}
extension TransactionStatusViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userType == "doner" {
            return self.obj_GetAllDonationHistory.allDonationaHistoryData.count
        } else if userType == "receiver" {
            return self.obj_GetAllReceiveHistory.allReceiveHistoryData.count
        } else if userType == "volunteer" {
            if screenType == "donation" {
                return self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData.count
            } else if screenType == "receive" {
                return self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData.count
            } else {
                return 0
            }
        } else {
            if screenType == "donation" {
                return self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData.count
            } else if screenType == "receive" {
                return self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData.count
            }  else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationRequestTableViewCell", for: indexPath) as! DonationRequestTableViewCell
        if userType == "doner" {
            cell.lbl_Date.text = self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].cretedAt ?? ""
            cell.lbl_CategoryName.text = (self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].subCategoryName ?? "")
            let status = obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].status ?? ""
            if status == "Completed" {
                cell.img_Status.image = UIImage(named: "Success")
            } else if status == "Pending" {
                cell.img_Status.image = UIImage(named: "14")
            } else {
                cell.img_Status.image = UIImage(named: "14")
            }
            cell.selectionStyle = .none
            return cell
            
        } else if userType == "receiver" {
            cell.lbl_Date.text = self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].cretedAt ?? ""
            cell.lbl_CategoryName.text = (self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].subCategoryName ?? "")
            let status = obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].status ?? ""
            if status == "Completed" {
                cell.img_Status.image = UIImage(named: "Success")
            } else if status == "Pending" {
                cell.img_Status.image = UIImage(named: "14")
            } else {
                cell.img_Status.image = UIImage(named: "14")
            }
            cell.selectionStyle = .none
            return cell
        } else if userType == "volunteer"{
            if screenType == "donation" {
                cell.lbl_Date.text = self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].cretedAt ?? ""
                cell.lbl_CategoryName.text = (self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].subCategoryName ?? "")
                let status = obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].status ?? ""
                if status == "Completed" {
                    cell.img_Status.image = UIImage(named: "Success")
                } else if status == "Pending" {
                    cell.img_Status.image = UIImage(named: "14")
                } else {
                    cell.img_Status.image = UIImage(named: "14")
                }
                cell.selectionStyle = .none
                return cell
            } else if screenType == "receive" {
                cell.lbl_Date.text = self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].cretedAt ?? ""
                cell.lbl_CategoryName.text = (self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].subCategoryName ?? "")
                let status = obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].status ?? ""
                if status == "Completed" {
                    cell.img_Status.image = UIImage(named: "Success")
                } else if status == "Pending" {
                    cell.img_Status.image = UIImage(named: "14")
                }else {
                    cell.img_Status.image = UIImage(named: "14")
                }
                cell.selectionStyle = .none
                return cell
            } else {
                return cell
            }
        } else {
            if screenType == "donation" {
                cell.lbl_Date.text = self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].cretedAt ?? ""
                cell.lbl_CategoryName.text = (self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].subCategoryName ?? "")
                let status = obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].status ?? ""
                if status == "Completed" {
                    cell.img_Status.image = UIImage(named: "Success")
                } else if status == "Pending" {
                    cell.img_Status.image = UIImage(named: "14")
                } else {
                    cell.img_Status.image = UIImage(named: "14")
                }
                cell.selectionStyle = .none
                return cell
            } else if screenType == "receive" {
                cell.lbl_Date.text = self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].cretedAt ?? ""
                cell.lbl_CategoryName.text = (self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].categoryName ?? "") + " / " + (self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].subCategoryName ?? "")
                let status = obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].status ?? ""
                if status == "Completed" {
                    cell.img_Status.image = UIImage(named: "Success")
                } else if status == "Pending" {
                    cell.img_Status.image = UIImage(named: "14")
                } else {
                    cell.img_Status.image = UIImage(named: "14")
                }
                cell.selectionStyle = .none
                return cell
            } else {
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userType == "doner" {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            nextVC.requestId = self.obj_GetAllDonationHistory.allDonationaHistoryData[indexPath.row].id ?? ""
            nextVC.userType = "doner"
            nextVC.isShowMatchedDetailsButton = self.isShowDetailsButton
            nextVC.isShowNavigationBar = true
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        } else if userType == "receiver" {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            nextVC.requestId = self.obj_GetAllReceiveHistory.allReceiveHistoryData[indexPath.row].id ?? ""
            nextVC.userType = "receiver"
            nextVC.isShowNavigationBar = true
            nextVC.isShowMatchedDetailsButton = self.isShowDetailsButton
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if userType == "volunteer" {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            nextVC.userType = "volunteer"
            if screenType == "donation" {
                nextVC.requestId = self.obj_GetAllDonationHistoryForVolunteer.allDonationaHistoryData[indexPath.row].id ?? ""
                nextVC.screenType = "donation"
                nextVC.isShowNavigationBar = true
            } else if screenType == "receive" {
                nextVC.requestId = self.obj_GetAllReceiveHistoryForVolunteer.allReceiveHistoryData[indexPath.row].id ?? ""
                nextVC.screenType = "receive"
                nextVC.isShowNavigationBar = true
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            nextVC.userType = "admin"
            if screenType == "donation" {
                nextVC.requestId = self.obj_GetAllDonationHistoryForAdmin.allDonationHistoryData[indexPath.row].id ?? ""
                nextVC.screenType = "donation"
                nextVC.isShowNavigationBar = true
                nextVC.isShowMatchedDetailsButton = self.isShowDetailsButton
            } else if screenType == "receive" {
                nextVC.requestId = self.obj_GetAllReceiveHistoryForAdmin.allReceiveHistoryData[indexPath.row].id ?? ""
                nextVC.screenType = "receive"
                nextVC.isShowNavigationBar = true
                nextVC.isShowMatchedDetailsButton = self.isShowDetailsButton
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        }
    }
}


