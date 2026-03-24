//
//  ReceivedRequestTableViewCell.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit

class ReceivedRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var btn_Request: UIButton!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let margins = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
          contentView.frame = contentView.frame.inset(by: margins)
    }
    
}
