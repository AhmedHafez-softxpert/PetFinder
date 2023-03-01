//
//  KeyChain.swift
//  PetFinderProject
//
//  Created by SoftXpert on 3/1/23.
//

import Foundation
import KeychainSwift

enum KeyChainValues: String {
    case accessToken = "access token"
}

class KeychainServices {
    static let shared = KeychainServices()
    
    let keyChainSwift = KeychainSwift()
    
    
    func getStoredData(ofType value: KeyChainValues) -> String? {
        let storedValue = keyChainSwift.get(value.rawValue)
        return storedValue
    }
    
    func saveValue(value: String, valueType: KeyChainValues) {
        let result = keyChainSwift.set(value, forKey: valueType.rawValue)
    }
    
    
}
