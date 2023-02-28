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
            configureContainerView(selected: isSelected)
        }
    }

    func configure(filter: String) {
        configureFilterLabel(filter: filter)
    }
}

//MARK: -

extension FilterCell {
    
    private func configureFilterLabel(filter: String) {
        filterLabel.text = filter
    }
    
    private func configureContainerView(selected: Bool) {
        containerView.backgroundColor = isSelected ? .cyan : UIColor(named: Constants.ColorName.cellBackgroundColor.rawValue)
    }
}
