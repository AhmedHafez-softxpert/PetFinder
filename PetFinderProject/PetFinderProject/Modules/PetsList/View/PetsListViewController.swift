//
//  PetsListViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit

class PetsListViewController: UIViewController {

    var presenter: PetsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DependencyFactory.shared.getPresenterForPetsListVC(vc: self)
        presenter?.onViewDidLoad()
        
    }
    

   

}
//MARK: -> PetsListPresenterToView

extension PetsListViewController: PetsListPresenterToView {
    func initUISetup() {
        print("initUISetup called from vc")
    }
    
    func didFetchAnimals() {
        print("did fetch animals called from vc")
    }
    
    
}
