//
//  PetsListInteractor.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import Foundation


class PetsListInteractor {
    
    var hasMore = true
    var nextPageUrl: String? = ""
    var isFetching = false
    var fetchLimit = 20
    
    
    func getAnimals(filterIndex: Int, nextPageUrl: String?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        NetworkManager.getAnimals(filterIndex: filterIndex, nextPageUrl: nextPageUrl) { response in
            completion(response)
        }
    }
    
    func configurePaginationVariables(response: AnimalsResponse?) {
        
        hasMore = (response?.pagination?.countPerPage ?? 0) == fetchLimit
        nextPageUrl = response?.pagination?.nextPage
        
        print("configurePaginationVariables hasMore val \(hasMore)")
        print("configurePaginationVariables nextPageUrl val \(nextPageUrl)")
    }
    
    func resetPaginationData() {
        hasMore = true
        nextPageUrl = ""
        isFetching = false
    }
    
    
}
