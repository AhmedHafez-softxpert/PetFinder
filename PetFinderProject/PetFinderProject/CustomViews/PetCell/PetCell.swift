//
//  PetCVC.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit
import SDWebImage

class PetCell: UICollectionViewCell {

    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petTypeLabel: UILabel!
    @IBOutlet weak var petGenderLabel: UILabel!
    @IBOutlet weak var petNameLabel: UILabel!
    
    var model: AnimalViewModel?
    
   
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
