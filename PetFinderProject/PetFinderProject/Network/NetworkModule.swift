//
//  NetworkModule.swift
//  PetFinderProject
//
//  Created by SoftXpert on 3/1/23.
//

import Foundation

import Alamofire
import Gloss


struct NetworkRequestInput {
    var url: String
    var method: HTTPMethod?
    var parameters: [String:Any]?
    var headers: HTTPHeaders?
}

// change response tuple with NetworkResponseData
struct NetworkResponseData {
    var statusCode: HTTPStatusCode?
    var json: Any?
    var error: AFError?
}

class NetworkModule {
    
    static let shared = NetworkModule()
    
    func getData(requestInput: NetworkRequestInput, completion: @escaping(_ response: NetworkResponseData) -> Void) {
        AF.request(requestInput.url, method: requestInput.method ?? .get, parameters: requestInput.parameters, headers: requestInput.headers).responseJSON { response in
            let result = response.result
            let statusCode = response.response?.statusCode ?? 0
            let httpStatusCode = HTTPStatusCode(rawValue: statusCode)
            switch result {
            case .success(let json):
                let responseData = NetworkResponseData(statusCode: httpStatusCode, json: json, error: nil)
                completion(responseData)
                
            case .failure(let error):
                print("")
                let responseData = NetworkResponseData(statusCode: httpStatusCode, json: nil, error: error)
                completion(responseData)
            }
            
        }
    }
}

