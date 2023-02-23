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
            print("interactor.getAnimals from presenter")
            self?.view.didFetchAnimals()
        }
    }
    
    func handleAnimalResponse(response: AnimalsResponse?) -> [AnimalViewModel] {
        var petsArr: [AnimalViewModel] = []
        guard response != nil else {return petsArr}
        let animals = response?.animals ?? []
        for animal in animals {
            var animalViewModel = convertAnimalToViewModel(animal: animal)
            petsArr.append(animalViewModel)
        }
        
        return petsArr
    }
    
    
    func convertAnimalToViewModel(animal: Animal) -> AnimalViewModel {
        let firstSmallPhoto = (animal.photos?.count ?? 0) > 0 ? (animal.photos?[0].small ?? "") : ""
        let firstMediumPhoto = (animal.photos?.count ?? 0) > 0 ? (animal.photos?[0].medium ?? "") : ""
        let address = animal.contact?.address
        let addressDetails = (address?.city ?? "") + (address?.state ?? "") + (address?.country ?? "")
        
        let animalViewModel = AnimalViewModel(name: animal.name ?? "NA", size: animal.size ?? "NA", type: animal.type ?? "NA", firstSmallPhotoUrl: firstSmallPhoto, firstMediumPhotoUrl: firstMediumPhoto, primaryColor: animal.primaryColor ?? "NA", address: addressDetails, url: animal.url ?? "")
        
        return animalViewModel
    }
   
    
}
