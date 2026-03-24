//
//  MatchedDonationViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit

class MatchedDonationViewController: UIViewController {
    
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var tbl_MatchedDonationList: UITableView!
    
    var navigationView = NavigationBarView()
    let obj_matchedRequestVM = MatchedRequestVM()
    var isShowNavigationBar = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_Navigation.frame.size.width, height: self.view_Navigation.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.matched.rawValue
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_Navigation.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        self.tbl_MatchedDonationList.register(UINib(nibName: "MatchedDonationListTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchedDonationListTableViewCell")
        self.obj_matchedRequestVM.getMatchedRequests(viewController: self)
        self.obj_matchedRequestVM.bindToController = {
            self.tbl_MatchedDonationList.reloadData()
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

extension MatchedDonationViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.obj_matchedRequestVM.matchedRequestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchedDonationListTableViewCell", for: indexPath) as! MatchedDonationListTableViewCell
        cell.lbl_CategoryTitle.text = obj_matchedRequestVM.matchedRequestData[indexPath.row].categoryDetails?.name
        let donerName = (obj_matchedRequestVM.matchedRequestData[indexPath.row].donerDetails?.firstName ?? "") + " " + (obj_matchedRequestVM.matchedRequestData[indexPath.row].donerDetails?.lastName ?? "")
        let receiverName = (obj_matchedRequestVM.matchedRequestData[indexPath.row].receiverDetails?.firstName ?? "") + " " + (obj_matchedRequestVM.matchedRequestData[indexPath.row].receiverDetails?.lastName ?? "")
        cell.lbl_MatchedPerson.text = donerName + " > " + receiverName
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MatchedDetailViewController") as! MatchedDetailViewController
        nextVC.donerDetails =  self.obj_matchedRequestVM.matchedRequestData[indexPath.row].donerDetails
        nextVC.receiverDetails = self.obj_matchedRequestVM.matchedRequestData[indexPath.row].receiverDetails
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
