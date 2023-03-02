//
//  SearchPetsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit

class PetsFilterViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var petsFilterCollectionView: UICollectionView!
    
    var presenter: PetsFilterOutput?

    var selectedFilter = ""
    var petsListVC: PetsListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForPetsFilterVC(vc: self)
        presenter?.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ViewControllerIdentifier.petsListVC.rawValue {
            petsListVC = segue.destination as! PetsListViewController
           
        }
    }
    
    private func setupFilterCollectionView() {
        petsFilterCollectionView.dataSource = self
        petsFilterCollectionView.delegate = self
        let cellName = PetsFilterConstants.FileName.filterCell.rawValue
        petsFilterCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        
    }
    
    func showLoadingView() {
        loadingView.isHidden = false
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
    }

}


//MARK: -> collection view methods
extension PetsFilterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      PetsFilterConstants.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellName = PetsFilterConstants.FileName.filterCell.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! FilterCell
        let filter = PetsFilterConstants.filters[indexPath.row]
        cell.configure(filter: filter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter = PetsFilterConstants.filters[indexPath.item]
        petsListVC?.selectedFilterIndex = indexPath.item
        petsListVC?.selectedFilter = selectedFilter
    }
    
    
}



//MARK: -> SearchPetsPresenterToView
extension PetsFilterViewController: PetsFilterInput {
    func initUISetup() {
        print("initUISetup called vc")
        setupFilterCollectionView()
    }


}

//MARK: - viper prtocols

protocol PetsFilterInput: AnyObject {
    func initUISetup()
}

protocol PetsFilterOutput: AnyObject {
    func viewDidLoad()
}
