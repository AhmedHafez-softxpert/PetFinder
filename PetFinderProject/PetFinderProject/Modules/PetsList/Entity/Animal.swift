//
//  Animal.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import Foundation
import Gloss



struct AnimalsResponse: JSONDecodable {
    let animals: [Animal]?
//    let pagination: Pagination
    
    init?(json: JSON) {
        self.animals = "animals" <~~ json
    }
}


struct Animal: JSONDecodable {
    var description: String?
    var name: String?
    var type: String?
    var gender: String?
    var photos: [AnimalPhoto]?
    var mixed: Bool?
    
    init?(json: JSON) {
        self.description = "description" <~~ json
        self.name = "name" <~~ json
        self.type = "type" <~~ json
        self.gender = "gender" <~~ json
        self.photos = "photos" <~~ json
        self.mixed = "breeds.mixed" <~~ json
    }
}




struct AnimalPhoto: JSONDecodable {
    var small, medium, large, full: String?
    
    init?(json: JSON) {
        self.small = "small" <~~ json
        self.medium = "medium" <~~ json
        self.large = "large" <~~ json
        self.full = "full" <~~ json
    }
    
    
}




