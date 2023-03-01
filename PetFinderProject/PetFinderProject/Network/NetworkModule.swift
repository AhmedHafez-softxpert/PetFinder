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
    
    func getData(requestInput: NetworkRequestInput, completion: @escaping(_ response: (statusCode: HTTPStatusCode? , json: Any?, error: AFError?)) -> Void) {
        AF.request(requestInput.url, method: requestInput.method ?? .get, parameters: requestInput.parameters, headers: requestInput.headers).responseJSON { response in
            let result = response.result
            let statusCode = response.response?.statusCode ?? 0
            let httpStatusCode = HTTPStatusCode(rawValue: statusCode)
            switch result {
            case .success(let json):
                completion((httpStatusCode, json, nil))
                
            case .failure(let error):
                print("")
                completion((httpStatusCode, nil, error))
            }
            
        }
    }
}

