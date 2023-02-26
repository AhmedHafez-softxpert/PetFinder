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

    var selectedFilter: String = "" {
        didSet {
            print("didSet selectedFilter \(selectedFilter)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForPetsListVC(vc: self)
        presenter?.viewDidLoad()
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
        
    }
    

    
}

//MARK: -> PetsListPresenterToView
extension PetsListViewController: PetsListInput {
   
    func setupUI() {
        print("initUISetup called from vc")
        setupPetsCollectionView()
    }
    
    func updateDataSource(animalsViewModel: AnimalsViewModel?) {
        pets.append(contentsOf: animalsViewModel?.animals ?? [])
    }
    
    func reloadData() {
        petsCollectionView.reloadData()
    }
    
    
    
    
}


//MARK: - Viper protocols

protocol PetsListOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
}

protocol PetsListInput: AnyObject {
    func setupUI()
    func updateDataSource(animalsViewModel: AnimalsViewModel?)
    func reloadData()
}


