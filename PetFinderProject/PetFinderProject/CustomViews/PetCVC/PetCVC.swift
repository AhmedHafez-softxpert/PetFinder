//
//  PetCVC.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit

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

}
