//
//  UIImageView+extension.swift
//  LaundryAdminApp
//
//  Created by Megha iOS on 28/05/21.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func setImage(url: String,placeholder:UIImage?) {
        
//        let urlString : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString : String = url.replacingOccurrences(of: " ", with: "")
        if  (urlString == "")
        {
            self.image =  placeholder
        }
        else
        {
            if let url = NSURL(string: urlString)
            {
                let sharedImageUrl: URL = url as URL
                self.sd_setImage(with: sharedImageUrl, placeholderImage: placeholder)
            }
            else
            {
                self.image =  placeholder
            }
        }
    }
}
