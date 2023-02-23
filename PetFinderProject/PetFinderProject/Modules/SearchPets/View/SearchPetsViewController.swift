//
//  SearchPetsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit

class SearchPetsViewController: UIViewController {
    
    @IBOutlet weak var petsFilterCollectionView: UICollectionView!
    
    
    var presenter: SearchPetsPresenter?
    let filters: [String] = ["All", "Cat", "Horse", "Bird", "Rabbit"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForSearchPetsVC(vc: self)
        presenter?.onViewDidLoad()
        NetworkManager.getAnimals { success in
            print("success get animals vc \(success)")
        }
        
    }
    
    
    func getAnimals() {
        NetworkManager.getAnimals { success in
            print("result from vc \(success)")
        }
    }
    
    private func setupFilterCollectionView() {
        petsFilterCollectionView.dataSource = self
        petsFilterCollectionView.delegate = self
        petsFilterCollectionView.register(UINib(nibName: "FilterCVC", bundle: nil), forCellWithReuseIdentifier: "FilterCVC")
        
    }

}


//MARK: -> collection view methods
extension SearchPetsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCVC", for: indexPath) as! FilterCVC
        let filter = filters[indexPath.row]
        cell.configure(filter: filter)
        return cell
    }
    
    
}



//MARK: -> SearchPetsPresenterToView
extension SearchPetsViewController: SearchPetsPresenterToView {
    func initUISetup() {
        print("initUISetup called vc")
        setupFilterCollectionView()
    }


}
