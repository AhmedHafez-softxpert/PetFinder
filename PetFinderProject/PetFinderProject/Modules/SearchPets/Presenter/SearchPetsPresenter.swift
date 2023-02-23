//
//  SearchPetsPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import Foundation

protocol SearchPetsPresenterToView: AnyObject {
    func initUISetup()
}


class SearchPetsPresenter {
    
    weak var view: SearchPetsPresenterToView?
    
    var interactor: SearchPetsInteractor?
    
    init(view: SearchPetsPresenterToView, interactor: SearchPetsInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func onViewDidLoad() {
        view?.initUISetup()
        print(" SearchPetsPresenter interactor will be printed  \(interactor)")
        interactor?.testImplementation()
    }
    
    
}
