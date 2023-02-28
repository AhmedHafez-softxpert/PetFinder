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
    
    private var router: PetsListRouter
    
    init(view: PetsListInput, interactor: PetsListInteractor, router: PetsListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    private func getAnimals() {
        let selectedFilterIndex = view.getSelectedFilterIndex()
        let nextPageUrl = view.getNextPageUrl()
        if nextPageUrl == nil {
            view.showLoadingView()
        }
        
        interactor.getAnimals(filterIndex: selectedFilterIndex, nextPageUrl: nextPageUrl) { [weak self] response in
            guard let self = self else {return}
            print("interactor.getAnimals from presenter")
            let previousAnimalsViewModel = self.view.getCurrentAnimalsViewModel()
            let animalsViewModel = AnimalsViewModel(from: response, previousAnimalsViewModel: previousAnimalsViewModel)
            self.view.updateAnimalsDataSource(animalsViewModel: animalsViewModel)
            self.view.reloadData()
            self.view.hideLoadingView()
        }
    }
    
   
    
}
//MARK: -> PetsListOutput

extension PetsListPresenter: PetsListOutput {

    func didSelectCell(at index: Int) {
        let animalsViewModel = view.getCurrentAnimalsViewModel()
        guard let selectedAnimal = animalsViewModel?.animals[index] else {return}
        router.goToAnimalDetails(animalViewModel: selectedAnimal)
    }
    
    func didReachedEndOfTable() {
        getAnimals()
    }
    
    func didAddNewFilter(filter: String) {
        print("filter from presenter class \(filter)")
        view.clearAnimalsViewModel()
        view.reloadData()
        getAnimals()
    }
    
    func viewDidLoad() {
        view.setupUI()
    }
    
    func viewWillAppear() {
        print("onViewWillAppear called from presenter")
    }
}
