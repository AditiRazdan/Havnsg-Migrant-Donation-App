//
//  AppDelegate.swift
//  Donation
//
//  Created by naxtre on 9/21/21.
//

import UIKit
import UserNotifications
import FirebaseCore
import FirebaseMessaging
@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate {
    
    var window: UIWindow?
    var deviceTokenString:String = ""
    let tabController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        if #available(iOS 10.0, *) {
//            UNUserNotificationCenter.current().delegate = self
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in })
//            UNUserNotificationCenter.current().delegate = self
//            Messaging.messaging().delegate = self
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            UIApplication.shared.registerUserNotificationSettings(settings)
//        }
//        UIApplication.shared.registerForRemoteNotifications()
//        if let launchOptions = launchOptions,
//           let notification = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification]
//            as? [AnyHashable : Any] {
//            print("Hello")
//        } else {
//            setInitialViewController()
//        }
//        FirebaseApp.configure()
        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, _ in
            print("🔔 Notification permission:", granted)
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
//        Messaging.messaging().token { token, error in
//          if let error = error {
//            print("Error fetching FCM registration token: \(error)")
//          } else if let token = token {
//            print("FCM registration token: \(token)")
//              self.deviceTokenString = token
//          }
//        }
        self.setInitialViewController()
        return true
    }
    
//  
//    func setInitialViewController(){
//        let autoLogin = obj_UserDefault.value(forKey: "autoLogin")
//        print(autoLogin as Any)
//        if (autoLogin != nil) {
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
//            let navigationController = UINavigationController.init(rootViewController: welcomeVC)
//            navigationController.navigationBar.isHidden = true
//            self.window?.rootViewController = navigationController
//        } else {
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "IntroductionViewController")
//            let navigationController = UINavigationController.init(rootViewController: initialViewController)
//            navigationController.navigationBar.isHidden = true
//            self.window?.rootViewController = navigationController
//        }
//    }
    
    func setInitialViewController(){
        let autoLogin = obj_UserDefault.value(forKey: "autoLogin")
        let userType = obj_UserDefault.value(forKey: "userType")
        print(autoLogin as Any)
        if (autoLogin != nil) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let tabVC = setTabBarViewControllers(userType: userType as! String )
            let themeColor = UIColor(hexString: Colors.themeColor.rawValue)
            tabController.viewControllers = tabVC
            tabController.selectedIndex = 0
            tabController.hidesBottomBarWhenPushed = false
            UITabBar.appearance().tintColor = UIColor(hexString: Colors.themeColor.rawValue)
            if #available(iOS 11.0, *) {
                UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
            } else {
                // Fallback on earlier versions
            }
            let navigationController = UINavigationController.init(rootViewController: tabController)
            navigationController.navigationBar.isHidden = true
            self.window?.rootViewController = navigationController
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "IntroductionViewController")
            let navigationController = UINavigationController.init(rootViewController: initialViewController)
            navigationController.navigationBar.isHidden = true
            self.window?.rootViewController = navigationController
        }
    }
    func setTabBarViewControllers(userType:String) -> [UIViewController] {
        let homeVC = createViewController(identifier: "WelcomeViewController")
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(named: "Home")
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.isNavigationBarHidden = true
//        let adminHomeVC = createViewController(identifier: "AdminHomeViewController")
//        adminHomeVC.tabBarItem.title = "Home"
//        adminHomeVC.tabBarItem.image = UIImage(named: "Home")
        var requestVC = UIViewController()
        if userType == "doner" {
            requestVC = createViewController(identifier: "DonationViewController")
            requestVC.tabBarItem.title = TabBarTitleForDoner.createRequest.rawValue
            requestVC.tabBarItem.image = UIImage(named: "Donation")
        } else if userType == "receiver" {
            requestVC = createViewController(identifier: "RequestFormViewController")
            requestVC.tabBarItem.title = TabBarTitleForReceiver.createRequest.rawValue
            requestVC.tabBarItem.image = UIImage(named: "Donation")
        }
        let requestNav = UINavigationController(rootViewController: requestVC)
        requestNav.isNavigationBarHidden = true
        
        let history = createViewController(identifier: "HistoryViewController")
        history.tabBarItem.title = TabBarTitleForDoner.account.rawValue
        history.tabBarItem.image = UIImage(named: "History")
        let historyNav = UINavigationController(rootViewController: history)
        historyNav.isNavigationBarHidden = true
        let pendingRequest = createViewController(identifier: "RequestViewController")
        if userType == "doner" {
            pendingRequest.tabBarItem.title = TabBarTitleForDoner.receivedRequest.rawValue
            pendingRequest.tabBarItem.image = UIImage(named: "HourGlass")
        } else if userType == "receiver" {
            pendingRequest.tabBarItem.title = TabBarTitleForReceiver.donationOffer.rawValue
            pendingRequest.tabBarItem.image = UIImage(named: "HourGlass")
        }
        let pendingNav = UINavigationController(rootViewController: pendingRequest)
        let category = createViewController(identifier: "AdminCategoryViewController")
        category.tabBarItem.title = "Category"
        category.tabBarItem.image = UIImage(named: "History")
        let categoryNav = UINavigationController(rootViewController: category)
        categoryNav.isNavigationBarHidden = true
        let subcategory = createViewController(identifier: "AdminSubCategoryViewController")
        subcategory.tabBarItem.title = "SubCategory"
        subcategory.tabBarItem.image = UIImage(named: "History")
        let subcategoryNav = UINavigationController(rootViewController: subcategory)
        subcategoryNav.isNavigationBarHidden = true
        
        let matched = createViewController(identifier: "MatchedDonationViewController")
        if userType == "volunteer" {
            matched.tabBarItem.title = TabBarTitleForVolunteer.matched.rawValue
        }
        matched.tabBarItem.title = "History"
        matched.tabBarItem.image = UIImage(named: "History")
        let matchNav = UINavigationController(rootViewController: matched)
        matchNav.isNavigationBarHidden = true
//        let history = createViewController(identifier: "HistoryViewController")
//        history.tabBarItem.title = "History"
//        history.tabBarItem.image = UIImage(named: "History")
        if userType == "receiver" || userType == "doner" {
            return [homeNav,requestNav,historyNav,pendingNav]
            //[homeVC,requestVC,history,pendingRequest]
        } else if userType == "volunteer" {
            return [homeNav,historyNav,matchNav]
            //[homeVC,history,matched]
        } else {
            return [homeNav,historyNav,categoryNav,subcategoryNav]
            //[homeVC,history,category,subcategory]
        }
    }
    func createViewController(identifier:String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        return vc
    }

    
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//
//        Messaging.messaging().apnsToken = deviceToken
//
//        let apns = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//        print("APNS:", apns)
//
//        Messaging.messaging().token { token, error in
//            if let error = error {
//                print("Error fetching FCM token: \(error)")
//                return
//            }
//            guard let fcmToken = token else { return }
//            
//            print("🔥 FCM Token Received:", fcmToken)
//            self.deviceTokenString = fcmToken   // << save here
//        }
//    }
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        #if DEBUG
        Messaging.messaging().setAPNSToken(deviceToken, type: .sandbox)
        print("📢 Using Sandbox APNs")
        #else
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
        print("📢 Using Production APNs")
        #endif

        let apnsToken = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("🍎 APNs Token:", apnsToken)

        Messaging.messaging().token { token, error in
            if let error = error {
                print("❌ Error fetching FCM token:", error)
                return
            }
            guard let fcmToken = token else { return }

            print("🔥 NEW FCM TOKEN:", fcmToken)
            self.deviceTokenString = fcmToken
        }
    }

    private func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    //    func application(
    //            _ application: UIApplication,
    //            didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    //            fetchCompletionHandler completionHandler:
    //            @escaping (UIBackgroundFetchResult) -> Void
    //            ) {
    //        isInitialController = true
    //
    //        gettingPushNotificationAndUpdateApp(userInfo)
    //        }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        //        gettingPushNotificationAndUpdateApp(userInfo)
        print(userInfo)
        completionHandler([.alert,.sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        //        gettingPushNotificationAndUpdateApp(userInfo)
        print(userInfo)
        completionHandler()
    }
    
}

