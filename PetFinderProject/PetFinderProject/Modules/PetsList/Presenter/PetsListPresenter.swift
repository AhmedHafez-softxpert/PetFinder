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
            let animalsViewModel = self.getAnimalsViewModel(from: response)
            self.view.updateDataSource(animalsViewModel: animalsViewModel)
            self.view.reloadData()
        }
    }
    
    // should I move this func to struct AnimalsViewModel?
    func getAnimalsViewModel(from response: AnimalsResponse?) -> AnimalsViewModel? {
        var petsArr: [AnimalViewModel] = []
        print("handleAnimalResponse init arr \(petsArr)")
        guard response != nil else {return nil}
        let animals = response?.animals ?? []
        for animal in animals {
            var animalViewModel = getAnimalViewModel(from: animal)
            petsArr.append(animalViewModel)
        }
        let nextPageUrl = response?.pagination?.nextPage
        let animalsViewModel = AnimalsViewModel(animals: petsArr, nextPageUrl: nextPageUrl)
        return animalsViewModel
    }
    
    
    func getAnimalViewModel(from animal: Animal) -> AnimalViewModel {
        let firstSmallPhoto = (animal.photos?.count ?? 0) > 0 ? (animal.photos?[0].small ?? "") : ""
        let firstMediumPhoto = (animal.photos?.count ?? 0) > 0 ? (animal.photos?[0].medium ?? "") : ""
        let address = animal.contact?.address
        let addressDetails = (address?.city ?? "") + (address?.state ?? "") + (address?.country ?? "")
        
        let animalViewModel = AnimalViewModel(name: animal.name ?? "NA", size: animal.size ?? "NA", type: animal.type ?? "NA", gender: animal.gender ?? "", firstSmallPhotoUrl: firstSmallPhoto, firstMediumPhotoUrl: firstMediumPhoto, primaryColor: animal.primaryColor ?? "NA", address: addressDetails, url: animal.url ?? "")
        
        return animalViewModel
    }
   
    
}
//MARK: -> PetsListOutput

extension PetsListPresenter: PetsListOutput {
    func viewDidLoad() {
        view.setupUI()
        getAnimals()
    }
    
    func viewWillAppear() {
        print("onViewWillAppear called from presenter")
    }
}
