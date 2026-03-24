//
//  HomeNavigationBar.swift
//  Donation
//
//  Created by Kanhu Dash on 12/10/21.
//

import UIKit

class HomeNavigationBar: UIView {
    @IBOutlet weak var btn_More: UIButton!
    @IBOutlet weak var btn_Profile: UIButton!
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HomeNavigationBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HomeNavigationBar
    }

}
