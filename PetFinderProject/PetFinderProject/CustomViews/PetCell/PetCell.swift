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
        configureImageView(url: model.firstSmallPhotoUrl)
        configureNameLabel(name: model.name)
        configureTypeLabel(type: model.type)
        configureGenderLabel(gender: model.gender)
        
    }

}

//MARK: - configure cell private methods

extension PetCell {
    
    private func configureImageView(url: String) {
        petImageView.setImageFromUrl(url: url)
    }
    
    private func configureNameLabel(name: String) {
        petNameLabel.text = name
    }
    
    private func configureTypeLabel(type: String) {
        petTypeLabel.text = type
    }
    
    private func configureGenderLabel(gender: String) {
        petGenderLabel.text = gender
    }
}
