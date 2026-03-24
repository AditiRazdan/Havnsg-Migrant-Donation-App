//
//  MatchedDonationListTableViewCell.swift
//  Donation
//
//  Created by Kanhu Dash on 09/10/21.
//

import UIKit

class MatchedDonationListTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_CategoryTitle: UILabel!
    @IBOutlet weak var lbl_MatchedPerson: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
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
