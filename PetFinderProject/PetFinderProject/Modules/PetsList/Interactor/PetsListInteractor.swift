//
//  PetsListInteractor.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import Foundation


class PetsListInteractor {
    
    func getAnimals(completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        NetworkManager.getAnimals { response in
            completion(response)
        }
    }
}
