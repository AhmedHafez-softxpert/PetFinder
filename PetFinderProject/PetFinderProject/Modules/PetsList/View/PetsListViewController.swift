//
//  PetsListViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit
import Alamofire

class PetsListViewController: UIViewController {

    @IBOutlet weak var petsCollectionView: UICollectionView!
    
    private var presenter: PetsListOutput?
    var animalsViewModel: AnimalsViewModel?
    
    var isFetchingAnimals: Bool = false
    
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
    
    //MARK: - private methods
   private func setupPetsCollectionView() {
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self
        petsCollectionView.register(UINib(nibName: "PetCell", bundle: nil), forCellWithReuseIdentifier: "PetCell")
    }
    
    
    
}

//MARK: -> collectionView Methods

extension PetsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animalsViewModel?.animals.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PetCell", for: indexPath) as? PetCell  else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "PetCell", for: indexPath)
        }
        if let petModel = self.animalsViewModel?.animals[indexPath.item] {
            cell.configure(model: petModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (animalsViewModel?.animals.count ?? 0) - 1 {
            // did reached end of table view
            print("did reach end of table isFetchingAnimals = \(isFetchingAnimals)")
            if isFetchingAnimals == false {
                presenter?.didReachedEndOfTable()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
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
    
   

    func setupUI() {
        print("initUISetup called from vc")
        setupPetsCollectionView()
    }
    
    func updateAnimalsDataSource(firstTime: Bool, animalsViewModel: AnimalsViewModel?) {
        if animalsViewModel != nil {
            let oldAnimals = self.animalsViewModel?.animals ?? []
            let newAnimals = animalsViewModel?.animals ?? []
            self.animalsViewModel = animalsViewModel
            if firstTime {
                self.animalsViewModel?.animals = newAnimals
            } else {
                self.animalsViewModel?.animals = oldAnimals + newAnimals
            }
            
        }
       
    }
    
    func reloadData() {
        self.petsCollectionView.reloadData()
    }
    
    func getSelectedFilter() -> String {
        return selectedFilter
    }
    
  
    func showLoadingView() {
        print("show loading called from PetsListViewController")
        isFetchingAnimals = true
        let parent = self.parent as! PetsFilterViewController
        parent.showLoadingView()
        
    }
    
    func hideLoadingView() {
        isFetchingAnimals = false
        let parent = self.parent as! PetsFilterViewController
        parent.hideLoadingView()
    }
    

    
    
    
    
}


//MARK: - Viper protocols

protocol PetsListOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func didAddNewFilter(filter: String)
    func didReachedEndOfTable()
}

protocol PetsListInput: AnyObject {
    func setupUI()
    func updateAnimalsDataSource(firstTime: Bool, animalsViewModel: AnimalsViewModel?)
    func reloadData()
    func getSelectedFilter() -> String
    func getSelectedFilterIndex() -> Int
    func getNextPageUrl() -> String?
    func showLoadingView()
    func hideLoadingView()
}


