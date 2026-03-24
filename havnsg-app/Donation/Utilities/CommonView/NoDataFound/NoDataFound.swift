//
//  NoDataFound.swift
//  Donation
//
//  Created by Kanhu Dash on 10/10/21.
//

import UIKit

class NoDataFound: UIView {
    
    class func instanceFromNib() -> UIView
    {
        return UINib(nibName: "NoDataFound", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        // self.setupView()
    }
    override  func awakeFromNib()
    {
        super.awakeFromNib()
        
    }
}
