//
//  TokenModel.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import Foundation
import Gloss


struct TokenModel: Codable {
    var access_token: String?
    
    init?(json: JSON) {
        self.access_token = "access_token" <~~ json
    }
    
}

