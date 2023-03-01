//
//  Constants.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit

struct Constants {
    
    static let apiKey = "OO076NFHirXwzkqwwO38rXaj8JjF6Jh5OrAySvmhSmgkUmiwkV"
    static let secretKey = "zPV0JgaIoIQ57RauCP2t6DewQ3uQYW02hT9iZrkF"
    
    
    static let baseUrl = "https://api.petfinder.com/v2/animals?"
    static let baseUrlForPagination = "https://api.petfinder.com"
    
    static let petsFilters: [String] = ["All", "Cat", "Horse", "Bird", "Rabbit"]
    
    
    enum FileName: String {
        case petCell = "PetCell"
        case filterCell = "FilterCell"
        case petInfoCell = "PetInfoCell"
        case petImageCell = "PetImageCell"
    }
    
    enum ColorName: String {
        case cellBackgroundColor = "CellBackgroundColor"
    }
    
    enum CellHeights: Double {
        case petCell = 110
    }
    
    enum StoryboardNames: String {
        case filterSB = "HomeScreen"
        case petsListSB = "PetsList"
        case petDetailsSB = "PetDetails"
    }
    
    enum ViewControllerIdentifier: String {
        case petsListVC = "PetsListViewController"
        case petsFilterVC = "PetsFilterViewController"
        case petDetailsVC = "PetDetailsViewController"
        case petsFilterNavigationController = "SearchPetsNavigationController"
    }
    
   
    
}
