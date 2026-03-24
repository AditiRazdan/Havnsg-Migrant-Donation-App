//
//  HomeViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 07/10/21.
//

import UIKit

struct Slide {
    var backGroundImage: UIImage
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var view_SideBar: UIView!
    @IBOutlet weak var collection_Slide_Image: UICollectionView!
    @IBOutlet weak var collection_Donation_Item: UICollectionView!
    @IBOutlet weak var view_Navigation: UIView!
    @IBOutlet weak var view_Outer: UIView!
    @IBOutlet weak var pageControl : UIPageControl!
    @IBOutlet weak var lbl_Message: UILabel!
    let obj_Category_VM = AdminCategoryVM()
    var currentIndex = 0
    var timer:Timer?
    let cell = SlideImageCollectionViewCell()
    var homeNavigationView = HomeNavigationBar()
    var isShowSideBar = false
    var sideBar = SideBar()
    
    let pages:[Slide] = [Slide(backGroundImage: UIImage(named: "hands-1")!),Slide(backGroundImage: UIImage(named: "asset-146")!),Slide(backGroundImage: UIImage(named: "Introduction")!)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userType = obj_UserDefault.value(forKey: "userType")
        if userType as! String == "doner" {
            self.lbl_Message.text = MessageInHomeScreen.messageForDonor.rawValue
        } else {
            self.lbl_Message.text = MessageInHomeScreen.messageForReceiver.rawValue
        }
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
        self.collection_Donation_Item.register(UINib(nibName: "DonationItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonationItemCollectionViewCell")
        self.collection_Slide_Image.register(UINib(nibName: "SlideImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SlideImageCollectionViewCell")
        self.obj_Category_VM.getCategoryApi(viewController: self)
        self.obj_Category_VM.bindToController = {
            self.collection_Donation_Item.reloadData()
        }
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.view_Outer.addGestureRecognizer(tapGestureRecognizer)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view_SideBar.isHidden = true
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
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collection_Slide_Image {
            return pages.count
        } else {
            return obj_Category_VM.categoryData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collection_Slide_Image {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideImageCollectionViewCell", for: indexPath) as! SlideImageCollectionViewCell
            cell1.backGroundImage.image = pages[indexPath.row].backGroundImage
            cell1.pageControl.addTarget(self, action: #selector(btn_action), for: .touchUpInside)
            return cell1
        } else {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationItemCollectionViewCell", for: indexPath) as! DonationItemCollectionViewCell
            cell2.lbl_Category_Title.text = obj_Category_VM.categoryData[indexPath.row].name
            let url = IMAGE_URL + (self.obj_Category_VM.categoryData[indexPath.row].image ?? "")
            cell2.img_Category.setImage(url: url, placeholder: nil)
            cell2.lbl_Category_Title.sizeToFit()
            return cell2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collection_Donation_Item {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeSubCategoryViewController") as! HomeSubCategoryViewController
            nextVC.categoryId = obj_Category_VM.categoryData[indexPath.row].id ?? ""
            nextVC.categoryName = obj_Category_VM.categoryData[indexPath.row].name ?? ""
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collection_Slide_Image {
            return CGSize(width: self.collection_Slide_Image.frame.size.width, height: self.collection_Slide_Image.frame.size.height)
        } else {
            return CGSize(width: self.collection_Donation_Item.frame.size.width / 3 - 5, height: self.collection_Donation_Item.frame.size.width / 3 + 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collection_Donation_Item {
            return 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collection_Donation_Item {
            return 5
        } else {
            return 0
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    @objc func btn_action(_ sender:UIPageControl) {
        let pc = sender
        collection_Slide_Image.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                            at: .centeredHorizontally, animated: true)
    }
}
