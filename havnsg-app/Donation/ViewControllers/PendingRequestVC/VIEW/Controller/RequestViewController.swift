//
//  ReceivedRequestViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit

class RequestViewController: UIViewController {
    
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var tbl_Received_Request: UITableView!
    
    var navigationView = NavigationBarView()
    var screenType = ""
    var obj_PendingRequests = PendingRequestVM()
    var obj_PendingDonationRequests = PendingDonationVM()
    var isShowNavigationBar = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tbl_Received_Request.register(UINib(nibName: "ReceivedRequestTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceivedRequestTableViewCell")
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_Navigation.frame.size.width, height: self.view_Navigation.frame.size.height)
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_Navigation.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if obj_UserDefault.value(forKey: "userType") as! String == "doner" {
            self.navigationView.lbl_Title.text = PageTite.receivedRequestForDoner.rawValue
            self.obj_PendingRequests.getPendingRequests(viewController: self)
            self.obj_PendingRequests.bindToController = {
                self.tbl_Received_Request.reloadData()
            }
        } else if obj_UserDefault.value(forKey: "userType") as! String == "receiver" {
            self.obj_PendingDonationRequests.getPendingDonationRequests(viewController: self)
            self.obj_PendingDonationRequests.bindToController = {
                self.tbl_Received_Request.reloadData()
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
    
    @IBAction func btn_AddClicked(_ sender: UIButton) {
        let userType = obj_UserDefault.value(forKey: "userType")
        if userType as! String == "doner" {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DonationViewController") as! DonationViewController
            nextVC.isShowNavigationBar = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else if userType as! String == "receiver" {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestFormViewController") as! RequestFormViewController
            nextVC.isShowNavigationBar = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
    }
}

extension RequestViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if obj_UserDefault.value(forKey: "userType") as! String == "doner" {
            return obj_PendingRequests.allPendingData.count
        } else if obj_UserDefault.value(forKey: "userType") as! String == "receiver" {
            return obj_PendingDonationRequests.allPendingData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedRequestTableViewCell", for: indexPath) as! ReceivedRequestTableViewCell
        if obj_UserDefault.value(forKey: "userType") as! String == "doner" {
            cell.btn_Request.setTitle("Donate", for: .normal)
            cell.lbl_Title.text = obj_PendingRequests.allPendingData[indexPath.row].subCategoryName ?? ""
            cell.lbl_Date.text = obj_PendingRequests.allPendingData[indexPath.row].cretedAt ?? ""
        } else if obj_UserDefault.value(forKey: "userType") as! String == "receiver" {
            cell.btn_Request.setTitle("Request", for: .normal)
            cell.lbl_Title.text = obj_PendingDonationRequests.allPendingData[indexPath.row].subCategoryName ?? ""
            cell.lbl_Date.text = obj_PendingDonationRequests.allPendingData[indexPath.row].cretedAt ?? ""
        }
        cell.btn_Request.tag = indexPath.row
        cell.btn_Request.addTarget(self, action: #selector(goToRequestForm), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @objc func goToRequestForm(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if obj_UserDefault.value(forKey: "userType") as! String == "doner" {
            if self.obj_PendingRequests.allPendingData[sender.tag].status == "Matched" {
                Utility().showPositiveMessage(message: "This Request is matched with someone else.", controller: self)
            } else {
                nextVC.screenType = "Received Request"
                if screenType == "donation" {
                    nextVC.userType = "doner"
                    nextVC.requestId = self.obj_PendingRequests.allPendingData[sender.tag].id ?? ""
                } else if screenType == "receive" {
                    nextVC.userType = "receiver"
                    nextVC.requestId = self.obj_PendingDonationRequests.allPendingData[sender.tag].id ?? ""
                } else {
                    let userType = obj_UserDefault.value(forKey: "userType") as! String
                    if userType == "receiver" {
                        nextVC.userType = "receiver"
                        nextVC.requestId = self.obj_PendingDonationRequests.allPendingData[sender.tag].id ?? ""
                    } else if userType == "doner" {
                        nextVC.userType = "doner"
                        nextVC.requestId = self.obj_PendingRequests.allPendingData[sender.tag].id ?? ""
                    }
                }
                nextVC.isPendingRequest = true
                nextVC.isEditable = false
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        } else {
            if self.obj_PendingDonationRequests.allPendingData[sender.tag].status == "Matched" {
                Utility().showPositiveMessage(message: "This Request is matched with someone else.", controller: self)
            } else {
                nextVC.screenType = "Received Request"
                if screenType == "donation" {
                    nextVC.userType = "doner"
                    nextVC.requestId = self.obj_PendingRequests.allPendingData[sender.tag].id ?? ""
                } else if screenType == "receive" {
                    nextVC.userType = "receiver"
                    nextVC.requestId = self.obj_PendingDonationRequests.allPendingData[sender.tag].id ?? ""
                } else {
                    let userType = obj_UserDefault.value(forKey: "userType") as! String
                    if userType == "receiver" {
                        nextVC.userType = "receiver"
                        nextVC.requestId = self.obj_PendingDonationRequests.allPendingData[sender.tag].id ?? ""
                    } else if userType == "doner" {
                        nextVC.userType = "doner"
                        nextVC.requestId = self.obj_PendingRequests.allPendingData[sender.tag].id ?? ""
                    }
                }
                nextVC.isPendingRequest = true
                nextVC.isEditable = false
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
