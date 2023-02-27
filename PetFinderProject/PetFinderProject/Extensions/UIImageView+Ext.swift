//
//  UIImageView+EXT.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/27/23.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageFromUrl(url: String) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "waitImage"))
    }
    
    
}
