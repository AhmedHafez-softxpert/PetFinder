//
//  FilterCVC.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(filter: String) {
        filterLabel.text = filter
    }
}
