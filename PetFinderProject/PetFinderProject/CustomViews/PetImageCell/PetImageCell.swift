//
//  PetImageCell.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import UIKit

class PetImageCell: UICollectionViewCell {
    
    @IBOutlet weak var petImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(url: String) {
        configureImageView(url: url)
    }
    

}

//MARK: -> private methods

extension PetImageCell {
    
    private func configureImageView(url: String) {
        petImageView.setImageFromUrl(url: url)
    }
}
