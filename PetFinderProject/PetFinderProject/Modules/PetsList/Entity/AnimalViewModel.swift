//
//  AnimalViewModel.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import Foundation


struct AnimalViewModel {
    
    var name: String
    var size: String
    var type: String
    var gender: String
    var firstSmallPhotoUrl: String
    var firstMediumPhotoUrl: String
    var primaryColor: String
    var address: String
    var url: String
    
    init(from animal: Animal) {
        let firstSmallPhoto = (animal.photos?.count ?? 0) > 0 ? (animal.photos?[0].small ?? "") : ""
        let firstMediumPhoto = (animal.photos?.count ?? 0) > 0 ? (animal.photos?[0].medium ?? "") : ""
        let address = animal.contact?.address
        let addressDetails = "\(address?.city ?? "") " + "\(address?.state ?? "") " + "\(address?.country ?? "")"

        self.name = animal.name ?? "NA"
        self.size = animal.size ?? "NA"
        self.type = animal.type ?? "NA"
        self.gender = animal.gender ?? ""
        self.firstSmallPhotoUrl = firstSmallPhoto
        self.firstMediumPhotoUrl = firstMediumPhoto
        self.primaryColor = animal.primaryColor ?? "NA"
        self.address = addressDetails
        self.url = animal.url ?? ""

    }
    
   
    
}




struct AnimalsViewModel {
    var animals: [AnimalViewModel]
    var nextPageUrl: String?
    
    init?(from response: AnimalsResponse?, previousAnimalsViewModel: AnimalsViewModel?) {
        var petsArr: [AnimalViewModel] = []
        if previousAnimalsViewModel != nil {
            petsArr.append(contentsOf: previousAnimalsViewModel?.animals ?? [])
        }
        print("handleAnimalResponse init arr \(petsArr)")
        guard response != nil else {return nil}
        let animals = response?.animals ?? []
        for animal in animals {
            var animalViewModel = AnimalViewModel(from: animal)
            petsArr.append(animalViewModel)
        }
        self.nextPageUrl = response?.pagination?.nextPage
        self.animals = petsArr
    }
    
    
}


