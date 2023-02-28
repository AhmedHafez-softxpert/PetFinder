//
//  PetInfoCell.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import UIKit

class PetInfoCell: UICollectionViewCell {

    
    @IBOutlet weak var infoContentLabel: UILabel!
    @IBOutlet weak var infoTypeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(content: String) {
        // content configuration  will be edidted later
        configureInfoContentLabel(content: content)
        configureInfoTypeLabel(type: content)
    }

}

//MARK: - private methods

extension PetInfoCell {
    
    private func configureInfoContentLabel(content: String) {
        infoContentLabel.text = content
    }
    
    private func configureInfoTypeLabel(type: String) {
        infoTypeLabel.text = type
    }
    
}
