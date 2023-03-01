//
//  NetworkManager.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import Foundation
import Alamofire
import Gloss


struct NetworkManager {
    
    static func getToken(completion: @escaping(_ success: Bool) -> Void) {
        let parameters: [String: Any] = [
            "grant_type": Constants.authApiGrantType,
            "client_id": "\(Constants.apiKey)",
            "client_secret": "\(Constants.secretKey)"
        ]
    
        AF.request(Constants.authUrl, method: .post, parameters: parameters).responseJSON { response in
            print("response json \( response )")
            let result = response.result
            switch result {
            case .success(let json):
                print("success part get token \(json)")
                let resultHandlejson = handleGetTokenJsonResult(json: json)
                completion(resultHandlejson)
                
            case .failure(let error):
                print("failure part get token \(error.localizedDescription)")
                completion(false)
            }
        }
        
    }
    
    static func handleGetTokenJsonResult(json: Any) -> Bool {
        let newJson = json as? JSON ?? ["": ""]
        let tokenModel: TokenModel? = TokenModel(json: newJson)
        print("autj model will be printed \(tokenModel)")
        if tokenModel != nil {
            KeychainServices.shared.saveValue(value: tokenModel?.access_token ?? "", valueType: .accessToken)
            return true
        } else {
            return false
        }
    }
    
    static func getAnimals(filterIndex: Int, nextPageUrl: String?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        let accessToken = KeychainServices.shared.getStoredData(ofType: .accessToken) ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]
        guard let url = getConfiguredUrl(filterIndex: filterIndex, nextPageUrl: nextPageUrl) else {
            completion(nil)
            return
        }
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            print("getAnimals response json \( response )")
            print("getAnimals status code will be printed \(response.response?.statusCode)")
            let result = response.result
            switch result {
            case .success(let json):
                print("success part getAnimals \(json)")
                let statusCode = response.response?.statusCode ?? 0
                let httpStatusCode = HTTPStatusCode(rawValue: statusCode)
                handleAnimalsHttpUrlResponse(filterIndex: filterIndex, nextPageUrl: nextPageUrl, json: json, httPStatusCode: httpStatusCode) { response in
                    completion(response)
                }
            case .failure(let error):
                print("failure part getAnimals \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    
    static func getNetworkRequestInputForGetAnimals(filterIndex: Int, nextPageUrl: String?) -> NetworkRequestInput? {
        let accessToken = KeychainServices.shared.getStoredData(ofType: .accessToken) ?? ""
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
        ]
        guard let url = getConfiguredUrl(filterIndex: filterIndex, nextPageUrl: nextPageUrl) else { return nil }
        let requestInput = NetworkRequestInput(url: url, method: .get, headers: headers)
        return requestInput
    }
    
    static func getAnimals2(filterIndex: Int, nextPageUrl: String?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        guard let requestInput = getNetworkRequestInputForGetAnimals(filterIndex: filterIndex, nextPageUrl: nextPageUrl) else {
            print("requestInput is nil")
            completion(nil)
            return
        }
        NetworkModule.shared.getData(requestInput: requestInput) { response in
            switch response.statusCode {
            case .ok:
                let json = response.json
                let animalsResponse = handleGetAnimalsSuccessCase(json: json)
                completion(animalsResponse)
            case .unauthorized:
                handleExpiredToken(filterIndex: filterIndex, nextPageUrl: nextPageUrl) { response in
                    completion(response)
                }
            default:
                print("default case switch getAnimals2")
                completion(nil)
            }
        }
    }
    
    
    static func getConfiguredUrl(filterIndex: Int, nextPageUrl: String?) -> String? {
        var url: String = ""

        let filterValue = filterIndex == 0 ? "" : "type=\(PetsFilterConstants.filters[filterIndex])"
        if nextPageUrl == nil {
           url = Constants.baseUrl + filterValue
            return url
        } else {
            guard nextPageUrl != nil else {return nil}
            url = Constants.baseUrlForPagination + (nextPageUrl ?? "")
            return url
        }
    }
    
    
    static func handleAnimalsHttpUrlResponse(filterIndex: Int, nextPageUrl: String?, json: Any, httPStatusCode: HTTPStatusCode?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        switch httPStatusCode {
        case .ok:
            print("getAnimals status code is 200")
            let animalsResponse = handleGetAnimalsSuccessCase(json: json)
            completion(animalsResponse)
        case .unauthorized:
            print("getAnimals status code is 401")
            handleExpiredToken(filterIndex: filterIndex, nextPageUrl: nextPageUrl) { response in
                completion(response)
            }
        default:
            print("default case switch ")
            completion(nil)
        }

    }
    
    static func handleAnimalsHttpUrlResponse2(filterIndex: Int, nextPageUrl: String?, json: Any, httPStatusCode: HTTPStatusCode?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        switch httPStatusCode {
        case .ok:
            print("getAnimals status code is 200")
            let animalsResponse = handleGetAnimalsSuccessCase(json: json)
            completion(animalsResponse)
        case .unauthorized:
            print("getAnimals status code is 401")
            handleExpiredToken(filterIndex: filterIndex, nextPageUrl: nextPageUrl) { response in
                completion(response)
            }
        default:
            print("default case switch ")
            completion(nil)
        }

    }
    
    static func handleGetAnimalsSuccessCase(json: Any?) -> AnimalsResponse? {
        let newJson = json as? JSON ?? ["": ""]
        print("handleGetAnimalsSuccessCase \(newJson)")
        let animalsResponse: AnimalsResponse? = AnimalsResponse(json: newJson)
        print("getAnimals animal response will be printed \(animalsResponse)")
        return animalsResponse
    }
    
    static func handleExpiredToken(filterIndex: Int , nextPageUrl: String?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        NetworkManager.getToken { success in
            if success {
                getAnimals2(filterIndex: filterIndex, nextPageUrl: nextPageUrl) { response in
                    completion(response)
                }
            } else {
                completion(nil)
            }
        }
    }
    
}
