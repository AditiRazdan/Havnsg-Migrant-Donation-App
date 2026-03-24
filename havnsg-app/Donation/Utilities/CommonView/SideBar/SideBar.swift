//
//  SideBar.swift
//  Donation
//
//  Created by Kanhu Dash on 16/10/21.
//

import UIKit

class SideBar: UIView {
    
    @IBOutlet weak var tbl_SideBar: UITableView!
    
    var viewController: UIViewController?
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "SideBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SideBar
    }
}

extension SideBar: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let userType = obj_UserDefault.value(forKey: "userType")
        if userType as! String == "doner" {
            return donerData.count
        } else if userType as! String == "receiver" {
            return receiverData.count
        } else if userType as! String == "volunteer" {
            return volunteerData.count
        } else {
            return adminData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideBarTableViewCell", for: indexPath) as! SideBarTableViewCell
        let userType = obj_UserDefault.value(forKey: "userType")
        if userType as! String == "doner" {
            cell.lbl_Data.text = donerData[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else if userType as! String == "receiver" {
            cell.lbl_Data.text = receiverData[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else if userType as! String == "volunteer" {
            cell.lbl_Data.text = volunteerData[indexPath.row]
            cell.selectionStyle = .none
            return cell
        } else {
            cell.lbl_Data.text = adminData[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userType = obj_UserDefault.value(forKey: "userType")
        switch indexPath.row {
        case 0:
            if userType as! String == "receiver" {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.userType = "receiver"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType as! String == "doner"{
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.userType = "doner"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType as! String == "volunteer" {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.screenType = "receive"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        case 1:
            if userType as! String == "receiver" {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
                nextVC.screenType = "receive"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType as! String == "doner"{
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
                nextVC.screenType = "donation"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType as! String == "volunteer"{
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.screenType = "donation"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "AddSubCategoryViewController") as! AddSubCategoryViewController
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        case 2:
            if userType as! String == "receiver" {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "RequestFormViewController") as! RequestFormViewController
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType as! String == "doner"{
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "DonationViewController") as! DonationViewController
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else if userType as! String == "volunteer"{
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "MatchedDonationViewController") as! MatchedDonationViewController
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.userType = "donation"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            }
            
        case 3:
            if userType as! String == "receiver" || userType as! String == "doner" || userType as! String == "volunteer" {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutUsViewController
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            } else {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                nextVC.userType = "receive"
                nextVC.isShowNavigationBar = true
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            }

        case 4:
            if userType as! String == "receiver" || userType as! String == "doner" || userType as! String == "volunteer" {
                let alertController = UIAlertController(title: "", message: "Are you sure? You want to logout? ", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                    Utility().deleteUserDefaults()
//                    let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
                    // 2️⃣ RESET ROOT VIEW CONTROLLER (IMPORTANT)
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let window = windowScene.windows.first {

                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let loginVC = storyboard.instantiateViewController(
                                withIdentifier: "LoginViewController"
                            )

                            let nav = UINavigationController(rootViewController: loginVC)
                            nav.navigationBar.isHidden = true

                            window.rootViewController = nav
                            window.makeKeyAndVisible()
                        }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.viewController?.present(alertController, animated: true, completion: nil)
            } else {
                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            }
       
        case 5:
            let alertController = UIAlertController(title: "", message: "Are you sure? You want to logout? ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                Utility().deleteUserDefaults()
                // 2️⃣ RESET ROOT VIEW CONTROLLER (IMPORTANT)
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {

                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginVC = storyboard.instantiateViewController(
                        withIdentifier: "LoginViewController"
                    )

                    let nav = UINavigationController(rootViewController: loginVC)
                    nav.navigationBar.isHidden = true

                    window.rootViewController = nav
                    window.makeKeyAndVisible()
                }
//                let nextVC = self.viewController?.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                self.viewController?.navigationController?.pushViewController(nextVC, animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.viewController?.present(alertController, animated: true, completion: nil)
            
        default:
            print("Hello")
        }
    }
}
