//
//  Helpers.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/22/23.
//

import Foundation
import Alamofire

struct Helpers {
    
    static func isConnectedToNetwork() -> Bool {
        if NetworkReachabilityManager.default?.isReachable == true {
            return true
        } else {
            return false
        }
    }
    
}
