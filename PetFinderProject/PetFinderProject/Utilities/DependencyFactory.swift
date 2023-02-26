//
//  DependencyFactory.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import UIKit


class DependencyFactory {
    
    static let shared = DependencyFactory()
    
    func getPresenterForSearchPetsVC(vc: PetsFilterPresenterToView) -> PetsFilterPresenter {
        let interactor = PetsFilterInteractor()
        let presenter = PetsFilterPresenter(view: vc, interactor: interactor)
        return presenter
    }
    
    func getPresenterForPetsListVC(vc: PetsListPresenterToView) -> PetsListPresenter {
        let interactor = PetsListInteractor()
        let presenter = PetsListPresenter(view: vc, interactor: interactor)
        return presenter
    }
    
    
}
