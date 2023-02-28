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
    
    
    
    //MARK: - private methods
    
    private func initPresenter() {
        presenter = DependencyFactory.shared.getPresenterForPetsListVC(vc: self)
    }
    
    private func setupPetsCollectionView() {
        petsCollectionView.dataSource = self
        petsCollectionView.delegate = self
        petsCollectionView.register(UINib(nibName: PetListConstants.FileName.petCell.rawValue, bundle: nil), forCellWithReuseIdentifier: PetListConstants.FileName.petCell.rawValue)
    }
    
    
    
}

//MARK: -> collectionView Methods

extension PetsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animalsViewModel?.animals.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellName = PetListConstants.FileName.petCell.rawValue
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? PetCell  else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath)
        }
        if let petModel = self.animalsViewModel?.animals[indexPath.item] {
            cell.configure(model: petModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt \(indexPath.item)")
        print("didSelectItemAt navigation Controller will be printed \(self.navigationController)")
        presenter?.didSelectCell(at: indexPath.row)
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
        return CGSize(width: collectionView.bounds.width, height: PetListConstants.petCellHeight)
    }
    
    

    
}

//MARK: -> PetsListPresenterToView
extension PetsListViewController: PetsListInput {
    func clearAnimalsViewModel() {
        animalsViewModel = nil 
    }
    
    
    func getCurrentAnimalsViewModel() -> AnimalsViewModel? {
        return animalsViewModel
    }
    
   
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
    
    func updateAnimalsDataSource(animalsViewModel: AnimalsViewModel?) {
        if animalsViewModel != nil {
            self.animalsViewModel = animalsViewModel
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
    func didSelectCell(at index: Int)
}

protocol PetsListInput: AnyObject {
    func setupUI()
    func updateAnimalsDataSource(animalsViewModel: AnimalsViewModel?)
    func clearAnimalsViewModel()
    func reloadData()
    func getSelectedFilter() -> String
    func getSelectedFilterIndex() -> Int
    func getCurrentAnimalsViewModel() -> AnimalsViewModel?
    func getNextPageUrl() -> String?
    func showLoadingView()
    func hideLoadingView()
}


