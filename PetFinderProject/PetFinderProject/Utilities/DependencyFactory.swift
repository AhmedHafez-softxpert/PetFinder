//
//  DependencyFactory.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import UIKit


class DependencyFactory {
    
    static let shared = DependencyFactory()
    
    func getPresenterForPetsFilterVC(vc: PetsFilterInput) -> PetsFilterPresenter {
        let interactor = PetsFilterInteractor()
        let presenter = PetsFilterPresenter(view: vc, interactor: interactor)
        return presenter
    }
    
    func getPresenterForPetsListVC(vc: PetsListInput) -> PetsListPresenter {
        let interactor = PetsListInteractor()
        let router = PetsListRouter()
        let presenter = PetsListPresenter(view: vc, interactor: interactor, router: router)
        return presenter
    }
    
    func getPresenterForPetDetailsVC(vc: PetDetailsInput) -> PetDetailsPresenter {
        let router = PetDetailsRouter()
        let petDetailsPresenter = PetDetailsPresenter(view: vc, router: router)
        return petDetailsPresenter
    }
    
    
}
