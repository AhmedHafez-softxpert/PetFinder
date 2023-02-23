//
//  DependencyFactory.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import UIKit


class DependencyFactory {
    
    static let shared = DependencyFactory()
    
    
    func getPresenterForSearchPetsVC(vc: SearchPetsPresenterToView) -> SearchPetsPresenter {
        
        let interactor = SearchPetsInteractor()
        let presenter = SearchPetsPresenter(view: vc, interactor: interactor)
        
        return presenter
        
        
    }
}
