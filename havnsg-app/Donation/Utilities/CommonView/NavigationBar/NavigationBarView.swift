//
//  NavigationBarView.swift
//  Donation
//
//  Created by user922181 on 9/26/21.
//

import UIKit

class NavigationBarView: UIView {
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var btn_Back: UIButton!
    @IBOutlet weak var img_LeftArrow: UIImageView!
    @IBOutlet weak var btn_Profile: UIButton!
    @IBOutlet weak var img_LeadingConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "NavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NavigationBarView
    }
}
