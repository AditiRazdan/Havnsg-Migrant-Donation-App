//
//  EventViewController.swift
//  Donation
//
//  Created by Kanhu Dash on 06/02/22.
//

import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var view_NavigationBar: UIView!
    @IBOutlet weak var lbl_Event: UILabel!
    var navigationView = NavigationBarView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        self.lbl_Event.text = Event.event.rawValue
        self.navigationView = NavigationBarView.instanceFromNib() as! NavigationBarView
        navigationView.frame = CGRect(x: 0, y: 0, width: self.view_NavigationBar.frame.size.width, height: self.view_NavigationBar.frame.size.height)
        self.navigationView.lbl_Title.text = PageTite.eventPage.rawValue
        view_NavigationBar.addSubview(navigationView)
        self.navigationView.btn_Back.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.navigationView.btn_Profile.addTarget(self, action: #selector(goToProfile), for: .touchUpInside)
    }
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
       }
    @objc func goToProfile(_ sender: UIButton) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

