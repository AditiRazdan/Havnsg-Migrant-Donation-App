//
//  TableViewCell.swift
//  Donation
//
//  Created by Kanhu Dash on 04/10/21.
//

import UIKit

class DonationRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_CategoryName: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    @IBOutlet weak var img_Status: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
