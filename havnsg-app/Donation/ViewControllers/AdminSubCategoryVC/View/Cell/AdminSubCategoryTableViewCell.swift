//
//  AdminSubCategoryTableViewCell.swift
//  Donation
//
//  Created by user922181 on 9/26/21.
//

import UIKit

class AdminSubCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_SubCategoryName: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var btn_EditClcked: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the vi for the selected state
    }
    override func layoutSubviews() {
          super.layoutSubviews()
          //set the values for top,left,bottom,right margins
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
