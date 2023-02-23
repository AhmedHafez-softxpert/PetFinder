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
    let pagination: Pagination?
    
    init?(json: JSON) {
        self.animals = "animals" <~~ json
        self.pagination = "pagination" <~~ json
    }
}


struct Animal: JSONDecodable {
    var description: String?
    var name: String?
    var type: String?
    var size: String?
    var gender: String?
    var photos: [AnimalPhoto]?
    var mixed: Bool?
    var contact: Contact?
    var primaryColor: String?
    var url: String?
    
    init?(json: JSON) {
        self.description = "description" <~~ json
        self.name = "name" <~~ json
        self.type = "type" <~~ json
        self.gender = "gender" <~~ json
        self.photos = "photos" <~~ json
        self.mixed = "breeds.mixed" <~~ json
        self.size = "size" <~~ json
        self.contact = "contact" <~~ json
        self.primaryColor = "colors.primary" <~~ json
        self.url = "url" <~~ json
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

struct Contact: JSONDecodable {
    let email, phone: String?
    let address: Address?
    
    init?(json: JSON) {
        self.email = "email" <~~ json
        self.phone = "phone" <~~ json
        self.address = "address" <~~ json
    }
}

// MARK: - Address
struct Address: JSONDecodable {
    
    let address1, address2, city, state: String?
    let postcode, country: String?
    
    init?(json: JSON) {
        self.address1 = "address1" <~~ json
        self.address2 = "address2" <~~ json
        self.city = "city" <~~ json
        self.state = "state" <~~ json
        self.country = "country" <~~ json
        self.postcode = "postcode" <~~ json
    }
}


struct Pagination: JSONDecodable {
    let countPerPage, totalCount, currentPage, totalPages: Int?
    let nextPage: String?
//    let links: PaginationLinks?
    
    init?(json: JSON) {
        self.countPerPage = "count_per_page" <~~ json
        self.totalCount = "total_count" <~~ json
        self.currentPage = "current_page" <~~ json
        self.totalPages = "total_pages" <~~ json
        self.nextPage = "_links.next.href" <~~ json

    }


}

// MARK: - PaginationLinks
struct PaginationLinks: Codable {
    let previous, next: Next
}



struct Next: Codable {
    let href: String
}



