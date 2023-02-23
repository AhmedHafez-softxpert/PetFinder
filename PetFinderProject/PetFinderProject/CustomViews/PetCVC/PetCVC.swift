//
//  PetCVC.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit
import SDWebImage

class PetCVC: UICollectionViewCell {

    @IBOutlet weak var containerViewWidthAnchor: NSLayoutConstraint!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var petGenderLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    
    
    var maxWidth: CGFloat? {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            containerViewWidthAnchor.constant = maxWidth
            containerViewWidthAnchor.isActive = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    func configure(model: AnimalViewModel) {
        petImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        petImageView.sd_setImage(with: URL(string: model.firstSmallPhotoUrl), placeholderImage: UIImage(named: "waitImage"))
        petNameLabel.text = model.name
        petTypeLabel.text = model.type
        petGenderLabel.text = model.gender
        
    }

}
