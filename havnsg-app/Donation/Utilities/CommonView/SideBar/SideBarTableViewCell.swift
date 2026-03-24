//
//  SideBarTableViewCell.swift
//  Donation
//
//  Created by Kanhu Dash on 16/10/21.
//

import UIKit

class SideBarTableViewCell: UITableViewCell
{
    @IBOutlet weak var lbl_Data: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
