//
//  PetsListViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit

class PetsListViewController: UIViewController {

    @IBOutlet weak var petsCollectionView: UICollectionView!
    
    var presenter: PetsListPresenter?
    var pets: [AnimalViewModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForPetsListVC(vc: self)
        presenter?.onViewDidLoad()
    }
    
    
    func setupPetsCollectionView() {
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self
        petsCollectionView.register(UINib(nibName: "PetCVC", bundle: nil), forCellWithReuseIdentifier: "PetCVC")
    }
    

   

}

//MARK: -> collectionView Methods

extension PetsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCVC", for: indexPath) as! PetCVC
        cell.maxWidth = collectionView.frame.width
        let petModel = pets[indexPath.item]
        cell.configure(model: petModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.item)")
        presenter?.getAnimals()
    }
    
    
    
    
    
    
    
}

//MARK: -> PetsListPresenterToView
extension PetsListViewController: PetsListPresenterToView {
    
    
    func initUISetup() {
        print("initUISetup called from vc")
        setupPetsCollectionView()
    }
    
    func didFetchAnimals(animals: [AnimalViewModel]) {
        print("did fetch animals called from vc")
        pets.append(contentsOf: animals)
        DispatchQueue.main.async {
            self.petsCollectionView.reloadData()
        }
    }
    
    
}
