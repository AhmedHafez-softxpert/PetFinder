//
//  PetsListPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import Foundation

protocol PetsListPresenterToView: AnyObject {
    func initUISetup()
    func didFetchAnimals()
}

class PetsListPresenter {
    
    var view: PetsListPresenterToView
    
    var interactor: PetsListInteractor
    
    init(view: PetsListPresenterToView, interactor: PetsListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func onViewDidLoad() {
        view.initUISetup()
        getAnimals()
    }
    
    func getAnimals() {
        interactor.getAnimals { [weak self] response in
            print("")
            self?.view.didFetchAnimals()
        }
    }
    
   
    
}
