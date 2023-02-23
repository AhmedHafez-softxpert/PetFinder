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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForSearchPetsVC(vc: self)
        presenter?.onViewDidLoad()
        NetworkManager.getAnimals { success in
            print("success get animals vc \(success)")
        }
        
    }
    
    //MARK: -
    //MARK: - private helpers

//    private func setupPresenter() {
//        presenter?.view = self
//    }
    
//    func getAnimalsNew() async {
//        
//        let emptyToken = Helpers.isTokenEmpty()
//        if emptyToken {
//            let result = await NetworkManager.getToken()
//            if result {
//                // success get token
//                let result = await NetworkManager.getAnimals()
//            }
//        } else {
//            let result = await NetworkManager.getAnimals()
//            let statusCode = result.statusCode
//            switch statusCode {
//            case 401:
//                print("getAnimalsNew invalid token result")
//            case 200:
//                print("getAnimalsNew status code 200")
//            default:
//                print("getAnimalsNew deafult case status code")
//            }
//        }
//        
//        
//    }
    
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
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCVC", for: indexPath) as! FilterCVC
        cell.filterLabel.text = "\(indexPath.item)"
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
