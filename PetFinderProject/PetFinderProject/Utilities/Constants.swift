//
//  Constants.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import Foundation

struct Constants {
    
    static let apiKey = "OO076NFHirXwzkqwwO38rXaj8JjF6Jh5OrAySvmhSmgkUmiwkV"
    static let secretKey = "zPV0JgaIoIQ57RauCP2t6DewQ3uQYW02hT9iZrkF"
    
    
    static let baseUrl = "https://api.petfinder.com/v2/animals?"
    static let baseUrlForPagination = "https://api.petfinder.com"
    
    static let petsFilters: [String] = ["All", "Cat", "Horse", "Bird", "Rabbit"]
    
    
    enum CellNames: String {
        case petCell = "PetCell"
        case filterCell = "FilterCell"
    }
    
    enum ColorsNames: String {
        case cellBackgroundColor = "CellBackgroundColor"
    }
}
