//
//  SearchPetsPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import Foundation

protocol PetsFilterPresenterToView: AnyObject {
    func initUISetup()
}


class PetsFilterPresenter {
    
    weak var view: PetsFilterPresenterToView?
    
    var interactor: PetsFilterInteractor?
    
    init(view: PetsFilterPresenterToView, interactor: PetsFilterInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func onViewDidLoad() {
        view?.initUISetup()
        print(" SearchPetsPresenter interactor will be printed  \(interactor)")
        interactor?.testImplementation()
    }
    
    
}
