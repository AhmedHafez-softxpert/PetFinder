//
//  PetDetailsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import UIKit

class PetDetailsViewController: UIViewController {

    @IBOutlet weak var petDetailsCollectionView: UICollectionView!
    
    var animalViewModel: AnimalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
    }
    

    //MARK: - private methods
    
    private func setupPetDetailsCollectionView() {
        petDetailsCollectionView.dataSource = self
        petDetailsCollectionView.delegate = self
        // register
        petDetailsCollectionView.register(UINib(nibName: Constants.FileName.petImageCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Constants.FileName.petImageCell.rawValue)
        petDetailsCollectionView.register(UINib(nibName: Constants.FileName.petInfoCell.rawValue, bundle: nil), forCellWithReuseIdentifier: Constants.FileName.petInfoCell.rawValue)
    }
    

   

}

//MARK: - collection view methods
extension PetDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.FileName.petImageCell.rawValue, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.FileName.petInfoCell.rawValue, for: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: collectionView.frame.width, height: 300)
        default:
            return CGSize(width: collectionView.frame.width, height: 40)
        }
    }
    
    
}


//MARK: -> PetDetailInput

extension PetDetailsViewController: PetDetailInput {
    func setupUI() {
       setupPetDetailsCollectionView()
    }
    
    
}

//MARK: - viper protocols

protocol PetDetailsOutput: AnyObject {
    func viewDidLoad()
    func didTapPetUrlButton()
}

protocol PetDetailInput: AnyObject {
    func setupUI() 
}
