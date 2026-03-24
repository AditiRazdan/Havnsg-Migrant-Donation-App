//
//  AdminHomeViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit

class AdminHomeViewController: UIViewController {

    @IBOutlet weak var view_SideBar: UIView!
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collection_Bottom: UICollectionView!
    @IBOutlet weak var collection_Middle: UICollectionView!
    @IBOutlet weak var collection_Slide_Image: UICollectionView!
    @IBOutlet weak var view_Outer: UIView!
    let pages:[Slide] = [Slide(backGroundImage: UIImage(named: "hands-1")!),Slide(backGroundImage: UIImage(named: "asset-149")!),Slide(backGroundImage: UIImage(named: "Introduction")!)]
    let volunteerData = ["All Receive Request","All Donation Request","Matched Requests","Pending Donation"]
    let adminData = ["AddCategory","AddSub-Category","AllCategory"]
//    let adminBottomData = ["AllCategory","AllSubCategory"]
    var isShowSideBar = false
    var sideBar = SideBar()
    var homeNavigationView = HomeNavigationBar()
    var userType = ""
    var currentIndex = 0
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userType = obj_UserDefault.value(forKey: "userType") as! String
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
        self.collection_Bottom.register(UINib(nibName: "DonationStatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonationStatusCollectionViewCell")
        self.collection_Slide_Image.register(UINib(nibName: "SlideImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SlideImageCollectionViewCell")
        self.collection_Middle.register(UINib(nibName: "DonationStatusCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonationStatusCollectionViewCell")
        self.collection_Bottom.isHidden = userType == "volunteer" ? true : false
//        self.pageControl.isHidden = userType == "volunteer" ? true : false
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.view_Outer.addGestureRecognizer(tapGestureRecognizer)
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
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
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        self.view_Outer.isHidden = true
        self.view_SideBar.isHidden = true
        self.isShowSideBar = false
        self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: self.view_SideBar.frame.size.height)
        UIView.setAnimationDuration(0.3)
        UIView.setAnimationDelegate(self)
        UIView.beginAnimations("TableAnimation", context: nil)
        self.view_SideBar.frame = CGRect(x: 0, y: 0, width: 0, height: 508)
    }
    @objc func changeImage() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [self] in
                    if currentIndex <= pages.count - 1 {
                        currentIndex = currentIndex + 1
                    } else {
                        currentIndex = 0
                    }
                    pageControl.currentPage = currentIndex
                    collection_Slide_Image.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0),
                                                       at: .right, animated: true)
                }
    }
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
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
}

extension AdminHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collection_Slide_Image {
            return pages.count
        } else if collectionView == collection_Middle {
            return userType == "volunteer" ? 4 : 3
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collection_Slide_Image {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideImageCollectionViewCell", for: indexPath) as! SlideImageCollectionViewCell
            cell1.backGroundImage.image = pages[indexPath.row].backGroundImage
            return cell1
        } else if collectionView == collection_Middle {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationStatusCollectionViewCell", for: indexPath) as! DonationStatusCollectionViewCell
            cell2.lbl_Donation_Status_Title.text = userType == "volunteer" ? self.volunteerData[indexPath.row] : self.adminData[indexPath.row]
            return cell2
        } else {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationStatusCollectionViewCell", for: indexPath) as! DonationStatusCollectionViewCell
//            cell3.lbl_Donation_Status_Title.text = self.adminBottomData[indexPath.row]
            return cell3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collection_Slide_Image {
            return CGSize(width: self.collection_Slide_Image.frame.size.width, height: self.collection_Slide_Image.frame.size.height)
        } else if collectionView == self.collection_Middle {
            return CGSize(width: self.collection_Middle.frame.size.width / 2 - 5, height: self.collection_Middle.frame.size.width / 3)
        } else {
            return CGSize(width: self.collection_Bottom.frame.size.width / 2 - 5, height: self.collection_Bottom.frame.size.width / 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collection_Middle {
            return 5
        } else if collectionView == self.collection_Bottom {
            return 5
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collection_Middle {
            if userType == "volunteer" {
                let historyVC = self.storyboard?.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
                switch indexPath.row {
                case 0 :
                    historyVC.screenType = "receive"
                    historyVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(historyVC, animated: true)
                case 1 :
                    historyVC.screenType = "donation"
                    historyVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(historyVC, animated: true)
                case 2 :
                    let matchedVC = self.storyboard?.instantiateViewController(withIdentifier: "MatchedDonationViewController") as! MatchedDonationViewController
                    matchedVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(matchedVC, animated: true)
                default:
                    let requestVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
                    requestVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(requestVC, animated: true)
                }
            } else if userType == "admin" {
                switch indexPath.row {
                case 0:
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
                    nextVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case 1:
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSubCategoryViewController") as! AddSubCategoryViewController
                    nextVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(nextVC, animated: true)
                case 2:
                    let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AdminCategoryViewController") as! AdminCategoryViewController
                    nextVC.isShowNavigationBar = true
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                default:
                    print("No case matched")
                }
            }
        }
//        else if collectionView == self.collection_Bottom {
//            switch indexPath.row {
//            case 0:
//                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AdminCategoryViewController") as! AdminCategoryViewController
//                self.navigationController?.pushViewController(nextVC, animated: true)
//            case 1:
//                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AdminSubCategoryViewController") as! AdminSubCategoryViewController
//                self.navigationController?.pushViewController(nextVC, animated: true)
//            default:
//                print("Hello")
//            }
//        }
//    }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
                pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            }
//        @objc func btn_action(_ sender:UIPageControl) {
//            let pc = sender
//            collection_Slide_Image.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
//                                                at: .centeredHorizontally, animated: true)
//        }
}
}
