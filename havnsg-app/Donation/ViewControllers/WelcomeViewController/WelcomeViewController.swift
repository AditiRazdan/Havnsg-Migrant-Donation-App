//
//  WelcomeViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 18/11/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var btn_WelcomeButton: UIButton!
    @IBOutlet weak var btn_SecondButton: UIButton!
    @IBOutlet weak var img_WelcomeImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var view_SideBar: UIView!
    @IBOutlet weak var view_Outer: UIView!
    var sideBar = SideBar()
    var isShowSideBar = false
    var homeNavigationView = HomeNavigationBar()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let tabController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view_SideBar.isHidden = true
        self.sideBar = SideBar.instanceFromNib() as! SideBar
        sideBar.frame = CGRect(x: 0, y: 0, width: self.view_SideBar.frame.size.width, height: self.view_SideBar.frame.size.height)
        sideBar.tbl_SideBar.register(UINib(nibName: "SideBarTableViewCell", bundle: nil), forCellReuseIdentifier: "SideBarTableViewCell")
        self.view_SideBar.addSubview(sideBar)
        self.sideBar.viewController = self
        self.homeNavigationView = HomeNavigationBar.instanceFromNib() as! HomeNavigationBar
        homeNavigationView.frame = CGRect(x: 0, y: 0, width: self.view_Navigation.frame.size.width, height: self.view_Navigation.frame.size.height)
        homeNavigationView.btn_More.setTitle("", for: .normal)
        homeNavigationView.btn_Profile.setTitle("", for: .normal)
        homeNavigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        homeNavigationView.btn_More.addTarget(self, action: #selector(openSideBar), for: .touchUpInside)
        self.view_Navigation.addSubview(homeNavigationView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.view_Outer.addGestureRecognizer(tapGestureRecognizer)
        if obj_UserDefault.value(forKey: "userType") as! String == "receiver" {
            btn_WelcomeButton.setTitle(ButtonTite.button1Receiver.rawValue, for: .normal)
            btn_SecondButton.setTitle(ButtonTite.button2Receiver.rawValue, for: .normal)
            img_WelcomeImage.image = UIImage(named: "ReceiverWelcome")
            welcomeLabel.text = WelcomeLabelText.receiver.rawValue
        } else if obj_UserDefault.value(forKey: "userType") as! String == "doner" {
            btn_WelcomeButton.setTitle(ButtonTite.button1Donor.rawValue, for: .normal)
            btn_SecondButton.setTitle(ButtonTite.button2Donor.rawValue, for: .normal)
            img_WelcomeImage.image = UIImage(named: "DonerWelcome")
            welcomeLabel.text = WelcomeLabelText.receiver.rawValue
        } else if obj_UserDefault.value(forKey: "userType") as! String == "volunteer" {
            btn_WelcomeButton.setTitle(ButtonTite.button1Volunteer.rawValue, for: .normal)
            btn_SecondButton.setTitle(ButtonTite.button2Volunteer.rawValue, for: .normal)
            img_WelcomeImage.image = UIImage(named: "VolunteerWelcome")
            welcomeLabel.text = WelcomeLabelText.receiver.rawValue
        } else {
            btn_WelcomeButton.setTitle(ButtonTite.button1Admin.rawValue, for: .normal)
            btn_SecondButton.setTitle(ButtonTite.button2Admin.rawValue, for: .normal)
            welcomeLabel.text = WelcomeLabelText.receiver.rawValue
        }
    }
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        self.view_SideBar.isHidden = true
        self.view_Outer.isHidden = true
        self.isShowSideBar = false
        self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: self.view_SideBar.frame.size.height)
        UIView.setAnimationDuration(0.3)
        UIView.setAnimationDelegate(self)
        UIView.beginAnimations("TableAnimation", context: nil)
        self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 508)
    }
    @objc func openSideBar(_ sender:UIButton) {
        self.view_SideBar.isHidden = false
        self.view_Outer.isHidden = false
        self.view_Outer.isUserInteractionEnabled = true
        self.view.bringSubviewToFront(view_SideBar)
        if !isShowSideBar {
            self.isShowSideBar = true
            self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 508)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: self.view_SideBar.frame.size.height)
        } else {
            self.view_SideBar.isHidden = true
            self.isShowSideBar = false
            self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: self.view_SideBar.frame.size.height)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationDelegate(self)
            UIView.beginAnimations("TableAnimation", context: nil)
            self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 508)
        }
    }
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.view_SideBar.isHidden = true
        self.isShowSideBar = false
        self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: self.view_SideBar.frame.size.height)
        UIView.setAnimationDuration(0.3)
        UIView.setAnimationDelegate(self)
        UIView.beginAnimations("TableAnimation", context: nil)
        self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 508)
    }
    func setInitialViewController (userType:String,buttonType:String) {
        if buttonType == "first" {
            if userType == "doner" {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DonationViewController") as! DonationViewController
                nextVC.isShowNavigationBar = true
                nextVC.hidesBottomBarWhenPushed = false
                self.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType == "receiver" {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestFormViewController") as! RequestFormViewController
                nextVC.hidesBottomBarWhenPushed = false
                nextVC.isShowNavigationBar = true
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
//            tabController.selectedIndex = 1
          
        } else{
//            tabController.selectedIndex = 2
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
            nextVC.isShowNavigationBar = true
            nextVC.hidesBottomBarWhenPushed = false
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
//
//        UITabBar.appearance().tintColor = UIColor(hexString: Colors.themeColor.rawValue)
//        if #available(iOS 11.0, *) {
//            UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
//        } else {
//            // Fallback on earlier versions
//        }
//        let navigationController = UINavigationController.init(rootViewController: tabController)
//        navigationController.navigationBar.isHidden = true
//        self.appDelegate.window?.rootViewController = navigationController
//    }
//    func setTabBarViewControllers(userType:String) -> [UIViewController] {
//        let homeVC = createViewController(identifier: "HomeViewController")
//        homeVC.tabBarItem.title = "Home"
//        homeVC.tabBarItem.image = UIImage(named: "Home")
//        let adminHomeVC = createViewController(identifier: "AdminHomeViewController")
//        adminHomeVC.tabBarItem.title = "Home"
//        adminHomeVC.tabBarItem.image = UIImage(named: "Home")
//        var requestVC = UIViewController()
//        if userType == "doner" {
//            requestVC = createViewController(identifier: "DonationViewController")
//            requestVC.tabBarItem.title = TabBarTitleForDoner.createRequest.rawValue
//            requestVC.tabBarItem.image = UIImage(named: "Donation")
//        } else if userType == "receiver" {
//            requestVC = createViewController(identifier: "RequestFormViewController")
//            requestVC.tabBarItem.title = TabBarTitleForReceiver.createRequest.rawValue
//            requestVC.tabBarItem.image = UIImage(named: "Donation")
//        }
//
//        let history = createViewController(identifier: "HistoryViewController")
//        history.tabBarItem.title = TabBarTitleForDoner.account.rawValue
//        history.tabBarItem.image = UIImage(named: "History")
//        let pendingRequest = createViewController(identifier: "RequestViewController")
//        if userType == "doner" {
//            pendingRequest.tabBarItem.title = TabBarTitleForDoner.receivedRequest.rawValue
//            pendingRequest.tabBarItem.image = UIImage(named: "HourGlass")
//        } else if userType == "receiver" {
//            pendingRequest.tabBarItem.title = TabBarTitleForReceiver.donationOffer.rawValue
//            pendingRequest.tabBarItem.image = UIImage(named: "HourGlass")
//        }
//        let category = createViewController(identifier: "AdminCategoryViewController")
//        category.tabBarItem.title = "Category"
//        category.tabBarItem.image = UIImage(named: "History")
//        let subcategory = createViewController(identifier: "AdminSubCategoryViewController")
//        subcategory.tabBarItem.title = "SubCategory"
//        subcategory.tabBarItem.image = UIImage(named: "History")
//        let matched = createViewController(identifier: "MatchedDonationViewController")
//        matched.tabBarItem.title = "History"
//        matched.tabBarItem.image = UIImage(named: "History")
////        let history = createViewController(identifier: "HistoryViewController")
////        history.tabBarItem.title = "History"
////        history.tabBarItem.image = UIImage(named: "History")
//        if userType == "receiver" || userType == "doner" {
//            return [homeVC,requestVC,history,pendingRequest]
//        } else if userType == "volunteer" {
//            return [adminHomeVC,history,matched]
//        } else {
//            return [adminHomeVC,history,category,subcategory]
//        }
//    }
//    func createViewController(identifier:String) -> UIViewController {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
//        return vc
    }
    @IBAction func btn_Clicked(_ sender: UIButton) {
//                    let userType = obj_UserDefault.value(forKey: "userType") as! String
//        self.setInitialViewController(userType: userType,buttonType:"first")
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func secondBtn_Clicked(_ sender: UIButton) {
//                        let userType = obj_UserDefault.value(forKey: "userType") as! String
//        self.setInitialViewController(userType: userType,buttonType:"second")
        self.tabBarController?.selectedIndex = 3
        }
}

