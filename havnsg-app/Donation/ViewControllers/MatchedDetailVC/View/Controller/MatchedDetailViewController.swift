//
//  MatchedDetailViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit

class MatchedDetailViewController: UIViewController {
    
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var lbl_DonerName: UILabel!
    @IBOutlet weak var lbl_DonerAddress: UILabel!
    @IBOutlet weak var lbl_DonerRegion: UILabel!
    @IBOutlet weak var lbl_DonerPhone: UILabel!
    @IBOutlet weak var lbl_ReceiverName: UILabel!
    @IBOutlet weak var lbl_ReceiverAddress: UILabel!
    @IBOutlet weak var lbl_ReceiverRegion: UILabel!
    @IBOutlet weak var lbl_ReceiverPhone: UILabel!
    @IBOutlet weak var lbl_Optional: UILabel!
    @IBOutlet weak var lbl_Title: UILabel!
    var navigationView = NavigationBarView()
    var donerDetails : MatchedRequestDonerDetail? = nil
    var receiverDetails : MatchedRequestReceiverDetail? = nil
    var obj_matchedRequestDetailById = MatchedDetailRequestIdVM()
    var requestId = ""
    var isShowLabel = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = obj_UserDefault.value(forKey: "userType") as! String
//        if userType == "doner" {
//            self.lbl_Title.text = "Receiver Detail"
//        } else {
//            self.lbl_Title.text = "Doner Detail"
//        }
        if isShowLabel {
            self.lbl_Optional.isHidden = false
            self.lbl_Optional.text = ButtonTite.optionaLabel.rawValue
        }
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_Navigation.frame.size.width, height: self.view_Navigation.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.matchedDetail.rawValue
        view_Navigation.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        setUI()
    }
    
    func setUI() {
        if requestId == "" {
            self.lbl_DonerName.text = "Name - " + (self.donerDetails?.firstName ?? "") + " " + (self.donerDetails?.lastName ?? "")
            self.lbl_DonerPhone.text = "Phone - " + (self.donerDetails?.mobile ?? "")
            self.lbl_DonerRegion.text = self.donerDetails?.region ?? ""
            self.lbl_DonerAddress.text = self.donerDetails?.address ?? ""
            self.lbl_ReceiverName.text = "Name - " + (self.receiverDetails?.firstName ?? "") + " " + (self.receiverDetails?.lastName ?? "")
            self.lbl_ReceiverPhone.text = "Phone - " + (self.receiverDetails?.mobile ?? "")
            self.lbl_ReceiverRegion.text = self.receiverDetails?.region ?? ""
            self.lbl_ReceiverAddress.text = self.receiverDetails?.address ?? ""
        } else {
            self.obj_matchedRequestDetailById.getMatchedRequestDetailsByRequestId(viewController: self, requestId: self.requestId)
            self.obj_matchedRequestDetailById.bindToController = {
                self.lbl_DonerName.text = "Name - " + (self.obj_matchedRequestDetailById.matchedRequestData[0].donerDetails?.firstName ?? "") + " " + (self.obj_matchedRequestDetailById.matchedRequestData[0].donerDetails?.lastName ?? "")
                self.lbl_DonerPhone.text = "Phone - " + (self.obj_matchedRequestDetailById.matchedRequestData[0].donerDetails?.mobile ?? "")
                self.lbl_DonerRegion.text = self.obj_matchedRequestDetailById.matchedRequestData[0].donerDetails?.region ?? ""
                self.lbl_DonerAddress.text = self.obj_matchedRequestDetailById.matchedRequestData[0].donerDetails?.address ?? ""
                self.lbl_ReceiverName.text = "Name - " + (self.obj_matchedRequestDetailById.matchedRequestData[0].receiverDetails?.firstName ?? "") + " " + (self.obj_matchedRequestDetailById.matchedRequestData[0].receiverDetails?.lastName ?? "")
                self.lbl_ReceiverPhone.text = "Phone - " + (self.obj_matchedRequestDetailById.matchedRequestData[0].receiverDetails?.mobile ?? "")
                self.lbl_ReceiverRegion.text = self.obj_matchedRequestDetailById.matchedRequestData[0].receiverDetails?.region ?? ""
                self.lbl_ReceiverAddress.text = self.obj_matchedRequestDetailById.matchedRequestData[0].receiverDetails?.address ?? ""
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
