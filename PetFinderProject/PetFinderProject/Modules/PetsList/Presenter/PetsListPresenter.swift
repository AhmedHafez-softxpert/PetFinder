//
//  PetsListPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import Foundation


class PetsListPresenter {
    
    private var view: PetsListInput
    
    private var interactor: PetsListInteractor
    
    init(view: PetsListInput, interactor: PetsListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    private func getAnimals() {
        interactor.getAnimals { [weak self] response in
            guard let self = self else {return}
            print("interactor.getAnimals from presenter")
            let animalsViewModel = AnimalsViewModel(from: response)
            self.view.updateAnimalsDataSource(animalsViewModel: animalsViewModel)
            self.view.reloadData()
            self.view.hideLoadingView()
        }
    }
    
   
    
}
//MARK: -> PetsListOutput

extension PetsListPresenter: PetsListOutput {
    
    func didAddNewFilter(filter: String) {
        print("filter from presenter class \(filter)")
        view.showLoadingView()
        view.clearAnimalsDataSource()
        getAnimals()
    }
    
    func viewDidLoad() {
        view.setupUI()
        getAnimals()
    }
    
    func viewWillAppear() {
        print("onViewWillAppear called from presenter")
    }
}
