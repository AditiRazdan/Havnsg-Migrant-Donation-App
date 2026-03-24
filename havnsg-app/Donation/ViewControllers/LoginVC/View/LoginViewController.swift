//
//  LoginViewController.swift
//  Donation
//
//  Created by naxtre on 9/21/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtFeild_phoneNumber: UITextField!
    @IBOutlet weak var txtFeild_password: UITextField!
    @IBOutlet weak var btn_Eye_TextPassword: UIButton!
    
    let obj_LoginWithPasswordVM = LoginWithPasswordVM()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let tabController = UITabBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_Eye_TextPassword.setTitle("", for: .normal)
        // Do any additional setup after loading the view.
        self.setUI()
        
        APIHandler.shared.setLocation()
    }
    
    func setUI()
    {
        Utility().changePlaceholderTetxColor(textField: txtFeild_phoneNumber, title: txtFeild_phoneNumber.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue)  )
        Utility().changePlaceholderTetxColor(textField: txtFeild_password, title: txtFeild_password.placeholder ?? "", color: UIColor.init(hexString: Colors.themeColor.rawValue))
        self.obj_LoginWithPasswordVM.bindToController = {
            let userType = self.obj_LoginWithPasswordVM.loginData?.userType ?? ""
            self.setInitialViewController(userType: userType)
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
//            self.navigationController?.hidesBottomBarWhenPushed = false
//            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func setInitialViewController (userType:String) {
        let tabVC = setTabBarViewControllers(userType: userType )
        tabController.viewControllers = tabVC
        tabController.selectedIndex = 0
        let navigationController = UINavigationController.init(rootViewController: tabController)
        navigationController.navigationBar.isHidden = true
//        tabBarController?.hidesBottomBarWhenPushed = false
        self.appDelegate.window?.rootViewController = navigationController
    }
    
    func setTabBarViewControllers(userType:String) -> [UIViewController] {
        let homeVC = createViewController(identifier: "WelcomeViewController")
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(named: "Home")
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.isNavigationBarHidden = true
//        let adminHomeVC = createViewController(identifier: "AdminHomeViewController")
//        adminHomeVC.title = "Home"
        var identiFier = ""
        var requestVC : UIViewController = UIViewController()
        if userType == "doner" {
            identiFier = "DonationViewController"
             requestVC = createViewController(identifier: identiFier)
            requestVC.tabBarItem.title = "CreateRequest"
            requestVC.tabBarItem.image = UIImage(named: "Donation")
        } else if userType == "receiver" {
            identiFier = "RequestFormViewController"
            requestVC = createViewController(identifier: identiFier)
            requestVC.tabBarItem.title = "CreateRequest"
            requestVC.tabBarItem.image = UIImage(named: "Donation")
        }
        let requestNav = UINavigationController(rootViewController: requestVC)
        requestNav.isNavigationBarHidden = true
        
        let history = createViewController(identifier: "HistoryViewController")
        history.tabBarItem.title = "History"
        history.tabBarItem.image = UIImage(named: "History")
        let historyNav = UINavigationController(rootViewController: history)
        historyNav.isNavigationBarHidden = true
        let pendingRequest = createViewController(identifier: "RequestViewController")
        if userType == "doner" {
            pendingRequest.tabBarItem.title = "ReceivedRequest"
            pendingRequest.tabBarItem.image = UIImage(named: "14")
        } else if userType == "receiver" {
            pendingRequest.tabBarItem.title = "Donation Offer"
            pendingRequest.tabBarItem.image = UIImage(named: "14")
        }
        let pendingNav = UINavigationController(rootViewController: pendingRequest)
        pendingNav.isNavigationBarHidden = true
        if userType == "receiver" || userType == "doner" {
            return [homeNav,requestNav,historyNav,pendingNav]
            //[homeVC,requestVC,history,pendingRequest]
        } else if userType == "volunteer" {
            return [homeNav,historyNav,pendingNav]
            //[homeVC,history,pendingRequest]
        } else {
            return [homeNav,historyNav,pendingNav]
            //[homeVC,history,pendingRequest]
        }
    }

    func createViewController(identifier:String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }
    
    @IBAction func ForgotPasswordClicked(_ sender: UIButton) {
        let controller = ForgotPasswordViewController.instatiate(from: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        if txtFeild_phoneNumber.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please enter phone number/email", controller: self)
            return
        }
        
        if txtFeild_password.text!.isEmpty {
            Utility().showPositiveMessage(message: "Please enter password", controller: self)
            return
        }
        let token = appDelegate.deviceTokenString.isEmpty
            ? "devicetoken"
            : appDelegate.deviceTokenString

            
            print("🔥 Device Token at Login:", token) // Console check
            
//            if token.isEmpty {
//                Utility().showPositiveMessage(message: "Device token not found yet. Please try again.", controller: self)
//                return
//            }
        self.obj_LoginWithPasswordVM.loginWithPasswordApi(viewController: self, param: ["username":self.txtFeild_phoneNumber.text ?? "", "password":txtFeild_password.text ?? "","deviceType":"IOS","deviceToken":token])
    }
    
    
    @IBAction func signUpClicked(_ sender: UIButton) {
        let controller = RegisterViewController.instatiate(from: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signInWithOTPClicked(_ sender: UIButton) {
        let controller = LoginWithOTPViewController.instatiate(from: .Main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnEyeClicked(_ sender:UIButton) {
            txtFeild_password.isSecureTextEntry = !txtFeild_password.isSecureTextEntry
            if txtFeild_password.isSecureTextEntry {
                sender.setImage(UIImage(named: "eyeOpen"), for: .normal)
            } else {
                sender.setImage(UIImage(named: "eyeClose"), for: .normal)
            }
    }
}
