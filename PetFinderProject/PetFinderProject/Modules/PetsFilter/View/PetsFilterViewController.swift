//
//  SearchPetsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit

class PetsFilterViewController: UIViewController {
    
    @IBOutlet weak var petsListContainerView: UIView!
    
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
    
    private func setupFilterCollectionView() {
        petsFilterCollectionView.dataSource = self
        petsFilterCollectionView.delegate = self
        let cellName = PetsFilterConstants.FileName.filterCell.rawValue
        petsFilterCollectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        
    }
    
    func showLoadingView() {
        print("show loadinf view called vc")
        loadingView.isHidden = false
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
    }
    
    private func addPetsListAsChild() {
        let sb = UIStoryboard(name: Constants.StoryboardNames.petsListSB.rawValue, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.petsListVC.rawValue) as! PetsListViewController
        addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        petsListContainerView.addSubview(vc.view)
        
        NSLayoutConstraint.activate([
            vc.view.leadingAnchor.constraint(equalTo: petsListContainerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: petsListContainerView.trailingAnchor),
            vc.view.topAnchor.constraint(equalTo: petsListContainerView.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: petsListContainerView.bottomAnchor)
        ])
        
        vc.didMove(toParent: self)
        
        petsListVC = vc
        
        
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
        addPetsListAsChild()
    }


}

//MARK: - viper prtocols

protocol PetsFilterInput: AnyObject {
    func initUISetup()
}

protocol PetsFilterOutput: AnyObject {
    func viewDidLoad()
}
