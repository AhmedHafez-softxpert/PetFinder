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
    
    func configure(index: Int, animalViewModel: AnimalViewModel?) {
        // content configuration  will be edidted later
        configureInfoTypeLabel(index: index)
        configureInfoContentLabel(index: index, animalViewModel: animalViewModel)
       
    }

}

//MARK: - private methods

extension PetInfoCell {
    
    private func configureInfoContentLabel(index: Int, animalViewModel: AnimalViewModel?) {
        switch index {
        case 1:
            infoContentLabel.text = animalViewModel?.name ?? "NA"
        case 2:
            infoContentLabel.text = animalViewModel?.size ?? "NA"
        case 3:
            infoContentLabel.text = animalViewModel?.primaryColor ?? "NA"
        case 4:
            infoContentLabel.text = animalViewModel?.address ?? "NA"
        default:
            infoContentLabel.text = "unknown"
            
        }
    }
    
    private func configureInfoTypeLabel(index: Int) {
        switch index {
        case 1:
            infoTypeLabel.text = "Name"
        case 2:
            infoTypeLabel.text = "Size"
        case 3:
            infoTypeLabel.text = "Color"
        case 4:
            infoTypeLabel.text = "Address"
        default:
            infoTypeLabel.text = "unknown"
        }
    }
    
}
