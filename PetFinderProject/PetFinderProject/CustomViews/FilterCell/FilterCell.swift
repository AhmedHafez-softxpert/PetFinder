//
//  FilterCVC.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .cyan : UIColor(named: "CellBackgroundColor")
        }
    }

    
    func configure(filter: String) {
        filterLabel.text = filter
    }
}
