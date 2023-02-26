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
    
    
    func getAnimals(url: String, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        if isFetching == false && hasMore == true {
            isFetching = true
            NetworkManager.getAnimals(url: url) { response in
                self.isFetching = false
                self.configurePaginationVariables(response: response)
                completion(response)
            }
        } else {
            print("isFetching = true or hasMore = false")
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
