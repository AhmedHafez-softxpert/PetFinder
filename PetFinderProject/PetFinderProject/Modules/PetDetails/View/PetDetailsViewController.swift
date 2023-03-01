//
//  PetDetailsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import UIKit

class PetDetailsViewController: UIViewController {

    @IBOutlet weak var petDetailsCollectionView: UICollectionView!
    
    
    var presenter: PetDetailsOutput?
    var animalViewModel: AnimalViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        presenter?.didTabBackButton()
    }
    
    
    @IBAction func petUrlButtonPressed(_ sender: UIButton) {
        presenter?.didTapPetUrlButton()
    }
    
    

    //MARK: - private methods
    
    private func initPresenter() {
        presenter = DependencyFactory.shared.getPresenterForPetDetailsVC(vc: self)
    }
    
    private func setupPetDetailsCollectionView() {
        petDetailsCollectionView.dataSource = self
        petDetailsCollectionView.delegate = self
        
        petDetailsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        // register cells
        petDetailsCollectionView.register(UINib(nibName: PetDetailsConstants.FileName.petImageCell.rawValue, bundle: nil), forCellWithReuseIdentifier: PetDetailsConstants.FileName.petImageCell.rawValue)
        petDetailsCollectionView.register(UINib(nibName: PetDetailsConstants.FileName.petInfoCell.rawValue, bundle: nil), forCellWithReuseIdentifier: PetDetailsConstants.FileName.petInfoCell.rawValue)
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetDetailsConstants.FileName.petImageCell.rawValue, for: indexPath) as? PetImageCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: PetDetailsConstants.FileName.petImageCell.rawValue, for: indexPath)
            }
            let url = animalViewModel?.firstMediumPhotoUrl ?? ""
            cell.configure(url: url)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetDetailsConstants.FileName.petInfoCell.rawValue, for: indexPath) as? PetInfoCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: PetDetailsConstants.FileName.petInfoCell.rawValue, for: indexPath)
            }
            cell.configure(index: indexPath.row, animalViewModel: self.animalViewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0:
            return CGSize(width: collectionView.frame.width, height: PetDetailsConstants.CellHeight.petImageCell.rawValue)
        default:
            return CGSize(width: collectionView.frame.width, height: PetDetailsConstants.CellHeight.petInfoCell.rawValue)
        }
    }
    
    
}


//MARK: -> PetDetailInput

extension PetDetailsViewController: PetDetailsInput {
    func getAnimalViewModel() -> AnimalViewModel? {
        return animalViewModel
    }
    
    func setupUI() {
       setupPetDetailsCollectionView()
    }
    
    
}

//MARK: - viper protocols

protocol PetDetailsOutput: AnyObject {
    func viewDidLoad()
    func didTapPetUrlButton()
    func didTabBackButton()
}

protocol PetDetailsInput: AnyObject {
    func setupUI()
    func getAnimalViewModel() -> AnimalViewModel?
}
