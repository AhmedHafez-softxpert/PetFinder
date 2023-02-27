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
    
    private func getAnimals(isFirstTime: Bool) {
        let url = getConfiguredUrl(isFirstTime: isFirstTime)
        guard let url = url else {return}
        if isFirstTime {
            view.showLoadingView()
        }
        
        interactor.getAnimals(url: url) { [weak self] response in
            guard let self = self else {return}
            print("interactor.getAnimals from presenter")
            let animalsViewModel = AnimalsViewModel(from: response)
            self.view.updateAnimalsDataSource(firstTime: isFirstTime, animalsViewModel: animalsViewModel)
            self.view.reloadData()
            self.view.hideLoadingView()
        }
    }
    
    func getConfiguredUrl(isFirstTime: Bool) -> String? {
        // move to network manager
        var url: String = ""
        let filter = view.getSelectedFilter()
        let filterIndex = view.getSelectedFilterIndex()
        let filterValue = filterIndex == 0 ? "" : "type=\(filter)"
        if isFirstTime {
           url = Constants.baseUrl + filterValue
            return url
        } else {
            let nextPageUrl = view.getNextPageUrl()
            guard nextPageUrl != nil else {return nil}
            url = Constants.baseUrlForPagination + nextPageUrl!
            return url
        }
    }
    
   
    
}
//MARK: -> PetsListOutput

extension PetsListPresenter: PetsListOutput {
    
    func didReachedEndOfTable() {
        getAnimals(isFirstTime: false)
    }
    
    
    func didAddNewFilter(filter: String) {
        print("filter from presenter class \(filter)")
        getAnimals(isFirstTime: true)
    }
    
    func viewDidLoad() {
        view.setupUI()
    }
    
    func viewWillAppear() {
        print("onViewWillAppear called from presenter")
    }
}
