//
//  AdminCategoryViewController.swift
//  Donation
//
//  Created by user922181 on 9/26/21.
//

import UIKit

class AdminCategoryViewController: UIViewController {
    @IBOutlet weak var tbl_Admin_Category: UITableView!
    @IBOutlet weak var view_NavigationBar: UIView!
    var navigationView = NavigationBarView()
    var obj_GetCategoryVM = AdminCategoryVM()
    var isShowNavigationBar = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.obj_GetCategoryVM.getCategoryApi(viewController: self)
        self.obj_GetCategoryVM.bindToController = {
            self.tbl_Admin_Category.reloadData()
        }
    }
    
    func setUI () {
        self.tbl_Admin_Category.register(UINib(nibName: "AdminCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "AdminCategoryTableViewCell")
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.category.rawValue
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
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
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

extension AdminCategoryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obj_GetCategoryVM.categoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminCategoryTableViewCell") as! AdminCategoryTableViewCell
        cell.selectionStyle = .none
        cell.lbl_CategoryTitle.text = self.obj_GetCategoryVM.categoryData[indexPath.row].name ?? ""
        cell.lbl_Time.text = self.obj_GetCategoryVM.categoryData[indexPath.row].cretedAt ?? ""
        cell.btn_EditClcked.addTarget(self, action: #selector(btn_EditClcked), for: .touchUpInside)
        cell.btn_EditClcked.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AdminSubCategoryViewController") as! AdminSubCategoryViewController
        nextVC.catData = self.obj_GetCategoryVM.categoryData[indexPath.row]
        nextVC.isShowNavigationBar = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func btn_EditClcked(sender: UIButton!) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
        nextVC.screenType = "AdminCategory"
        nextVC.catgoyName = self.obj_GetCategoryVM.categoryData[sender.tag].name ?? ""
        nextVC.categoryId = self.obj_GetCategoryVM.categoryData[sender.tag].id ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
       }
}
