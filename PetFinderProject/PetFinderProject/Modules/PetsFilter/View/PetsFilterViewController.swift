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
    
    var presenter: PetsFilterPresenter?
    let filters: [String] = ["All", "Cat", "Horse", "Bird", "Rabbit"]

    var selectedFilter = ""
    var petsListVC: PetsListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForPetsFilterVC(vc: self)
        presenter?.onViewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PetsFilterViewController" {
            petsListVC = segue.destination as! PetsListViewController
           
        }
    }
    
    private func setupFilterCollectionView() {
        petsFilterCollectionView.dataSource = self
        petsFilterCollectionView.delegate = self
        petsFilterCollectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        
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
        filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        let filter = filters[indexPath.row]
        cell.configure(filter: filter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFilter = filters[indexPath.item]
        petsListVC?.selectedFilterIndex = indexPath.item
        petsListVC?.selectedFilter = selectedFilter
    }
    
    
}



//MARK: -> SearchPetsPresenterToView
extension PetsFilterViewController: PetsFilterPresenterToView {
    func initUISetup() {
        print("initUISetup called vc")
        setupFilterCollectionView()
    }


}
