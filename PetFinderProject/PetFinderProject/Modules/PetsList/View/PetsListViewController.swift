//
//  PetsListViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit

class PetsListViewController: UIViewController {

    @IBOutlet weak var petsCollectionView: UICollectionView!
    
    private var presenter: PetsListOutput?
    var pets: [AnimalViewModel] = []
    var animalsViewModel: AnimalsViewModel?
    
    var selectedFilterIndex = 0
    var selectedFilter: String = "" {
        didSet {
            print("didSet selectedFilter \(selectedFilter)")
            presenter?.didAddNewFilter(filter: selectedFilter)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
        presenter?.viewDidLoad()
    }
    
    func initPresenter() {
        presenter = DependencyFactory.shared.getPresenterForPetsListVC(vc: self)
    }
    
    
    func setupPetsCollectionView() {
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self
        petsCollectionView.register(UINib(nibName: "PetCell", bundle: nil), forCellWithReuseIdentifier: "PetCell")
    }
    
    
    
}

//MARK: -> collectionView Methods

extension PetsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCell", for: indexPath) as! PetCell
        cell.maxWidth = collectionView.frame.width
        print("pets will be printed \(self.pets)")
        print("indexPath.item will be printed \(indexPath.item)")
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
    func getSelectedFilterIndex() -> Int {
        return selectedFilterIndex
    }
    
    
    func getNextPageUrl() -> String? {
        return animalsViewModel?.nextPageUrl
    }
    
    func hideLoadingView() {
        let parent = self.parent as! PetsFilterViewController
        parent.hideLoadingView()
    }
    
    
    
   
    func setupUI() {
        print("initUISetup called from vc")
        setupPetsCollectionView()
    }
    
    func updateAnimalsDataSource(animalsViewModel: AnimalsViewModel?) {
        self.animalsViewModel = animalsViewModel
        pets.append(contentsOf: animalsViewModel?.animals ?? [])
    }
    
    func reloadData() {
        petsCollectionView.reloadData()
        
    }
    
    func getSelectedFilter() -> String {
        return selectedFilter
    }
    
    func clearAnimalsDataSource() {
        pets = []
    }
    
    func showLoadingView() {
        print("show loading called from PetsListViewController")
        let parent = self.parent as! PetsFilterViewController
        parent.showLoadingView()
        
    }

    
    
    
    
}


//MARK: - Viper protocols

protocol PetsListOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didAddNewFilter(filter: String)
}

protocol PetsListInput: AnyObject {
    func setupUI()
    func updateAnimalsDataSource(animalsViewModel: AnimalsViewModel?)
    func reloadData()
    func getSelectedFilter() -> String
    func getSelectedFilterIndex() -> Int
    func getNextPageUrl() -> String?
    func clearAnimalsDataSource()
    func showLoadingView()
    func hideLoadingView()
}


