//
//  AdminSubCategoryViewController.swift
//  Donation
//
//  Created by user922181 on 9/26/21.
//

import UIKit
class AdminSubCategoryViewController: UIViewController {

    @IBOutlet weak var view_NavigationBar: UIView!
    @IBOutlet weak var tbl_AdminSubCategory: UITableView!
    var navigationView = NavigationBarView()
    let obj_SubCategoryVM = AdminSubCategoryVM()
    var catData : AdminCategoryDatum?
    var isShowNavigationBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let id = catData?.id else {
            return
        }
        self.obj_SubCategoryVM.getSubCategoryApi(viewController: self, categoryId: id)
        self.obj_SubCategoryVM.bindToController = {
            self.tbl_AdminSubCategory.reloadData()
        }
    }
    func setUI() {
        self.tbl_AdminSubCategory.register(UINib(nibName: "AdminSubCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminSubCategoryTableViewCell")
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.subCategory.rawValue
        if !self.isShowNavigationBar {
            self.navigationView.img_LeftArrow.isHidden = true
            self.navigationView.img_LeadingConstraint.isActive = false
            self.navigationView.img_LeftArrow.frame.size.width = 0
        }
        view_NavigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
    }
    
    @IBAction func btn_Add(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSubCategoryViewController") as! AddSubCategoryViewController
        nextVC.categoryId = self.catData?.id ?? ""
        nextVC.isShowNavigationBar = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
       }
    
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension AdminSubCategoryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.obj_SubCategoryVM.subCategoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminSubCategoryTableViewCell") as! AdminSubCategoryTableViewCell
        cell.selectionStyle = .none
        cell.lbl_SubCategoryName.text = self.obj_SubCategoryVM.subCategoryData[indexPath.row].name
        cell.lbl_Time.text = self.obj_SubCategoryVM.subCategoryData[indexPath.row].cretedAt
        cell.btn_EditClcked.addTarget(self, action: #selector(btn_EditClcked), for: .touchUpInside)
        cell.btn_EditClcked.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    @objc func btn_EditClcked(sender: UIButton!) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSubCategoryViewController") as! AddSubCategoryViewController
        nextVC.screenType = "AdminSubCategory"
        nextVC.categoryName = self.obj_SubCategoryVM.subCategoryData[sender.tag].categoryName ?? ""
        nextVC.subCategoryName = self.obj_SubCategoryVM.subCategoryData[sender.tag].name ?? ""
        nextVC.categoryId = self.obj_SubCategoryVM.subCategoryData[sender.tag].parentCategory ?? ""
        nextVC.subCategoryId = self.obj_SubCategoryVM.subCategoryData[sender.tag].id ?? ""
        nextVC.isShowNavigationBar = true
        self.navigationController?.pushViewController(nextVC, animated: true)
       }
}
