//
//  SearchPetsPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import Foundation




class PetsFilterPresenter {
    
    weak var view: PetsFilterInput?
    
    var interactor: PetsFilterInteractor?
    
    init(view: PetsFilterInput, interactor: PetsFilterInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func onViewDidLoad() {
        view?.initUISetup()
        print(" SearchPetsPresenter interactor will be printed  \(interactor)")
        interactor?.testImplementation()
    }
    
    
}
//MARK: - PetsFilterOutput

extension PetsFilterPresenter: PetsFilterOutput {
    func viewDidLoad() {
        view?.initUISetup()
        print(" SearchPetsPresenter interactor will be printed  \(interactor)")
        interactor?.testImplementation()
    }
    
    
}
