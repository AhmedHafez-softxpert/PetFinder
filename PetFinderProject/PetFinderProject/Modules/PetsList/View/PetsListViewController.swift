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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCVC", for: indexPath) as! PetCVC
        cell.maxWidth = collectionView.frame.width
        cell.petNameLabel.text = "name namenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamenamename"
        
        return cell
    }
    
    
    
    
    
    
    
}

//MARK: -> PetsListPresenterToView
extension PetsListViewController: PetsListPresenterToView {
    func initUISetup() {
        print("initUISetup called from vc")
        setupPetsCollectionView()
    }
    
    func didFetchAnimals() {
        print("did fetch animals called from vc")
    }
    
    
}
