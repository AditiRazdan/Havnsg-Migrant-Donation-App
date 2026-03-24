//
//  IntroductionCollectionViewCell.swift
//  Donation
//
//  Created by Kanhu Dash on 06/10/21.
//

import UIKit

class IntroductionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var txt_Description: UITextView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var img_BackGround_Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
