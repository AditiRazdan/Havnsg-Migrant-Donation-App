//
//  HomeSubCategoryViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 10/10/21.
//

import UIKit

class HomeSubCategoryViewController: UIViewController {
    
    @IBOutlet weak var view_navigation: UIView!
    @IBOutlet weak var collection_HomeSubCategory: UICollectionView!
    
    var navigationView = NavigationBarView()
    var categoryId = ""
    var categoryName = ""
    var obj_SubCategory = AdminSubCategoryVM()
    var view_NoDataFound = NoDataFound()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        self.view_NoDataFound = NoDataFound.instanceFromNib() as! NoDataFound
        self.view_NoDataFound.isHidden = true
            self.view_NoDataFound.frame = CGRect(x: 0, y: 0, width: self.collection_HomeSubCategory.frame.size.width, height: self.collection_HomeSubCategory.frame.size.height)
        self.collection_HomeSubCategory.addSubview(self.view_NoDataFound)
        self.collection_HomeSubCategory.register(UINib(nibName: "DonationItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DonationItemCollectionViewCell")
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_navigation.frame.size.width, height: self.view_navigation.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.subCategory.rawValue
        view_navigation.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
        self.obj_SubCategory.getSubCategoryApi(viewController: self, categoryId: categoryId)
        self.obj_SubCategory.bindToController = {
            self.collection_HomeSubCategory.reloadData()
            if self.obj_SubCategory.subCategoryData.count == 0 {
                self.view_NoDataFound.isHidden = false
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

extension HomeSubCategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return obj_SubCategory.subCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationItemCollectionViewCell", for: indexPath) as! DonationItemCollectionViewCell
        cell.lbl_Category_Title.text = self.obj_SubCategory.subCategoryData[indexPath.row].name
        let url = IMAGE_URL + (self.obj_SubCategory.subCategoryData[indexPath.row].image ?? "")
        cell.img_Category.setImage(url: url, placeholder: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collection_HomeSubCategory.frame.size.width / 3 - 5, height: self.collection_HomeSubCategory.frame.size.width / 3 - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userType = obj_UserDefault.value(forKey: "userType")
        if userType as! String == "doner" {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DonationViewController") as! DonationViewController
            nextVC.category = self.categoryName
            nextVC.subCategory = self.obj_SubCategory.subCategoryData[indexPath.row].name ?? ""
            nextVC.categoryId = self.categoryId
            nextVC.subCategoryId = self.obj_SubCategory.subCategoryData[indexPath.row].id ?? ""
            nextVC.isShowNavigationBar = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestFormViewController") as! RequestFormViewController
            nextVC.category = self.categoryName
//            nextVC.screenType = "Subcategory"
            nextVC.subCategory = self.obj_SubCategory.subCategoryData[indexPath.row].name ?? ""
            nextVC.categoryId = self.categoryId
            nextVC.subCategoryId = self.obj_SubCategory.subCategoryData[indexPath.row].id ?? ""
            nextVC.isShowNavigationBar = true
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }

}
