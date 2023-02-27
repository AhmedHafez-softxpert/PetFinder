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
            "grant_type": "client_credentials",
            "client_id": "\(Constants.apiKey)",
            "client_secret": "\(Constants.secretKey)"
        ]
        
        let authUrl = "https://api.petfinder.com/v2/oauth2/token"
        
        AF.request(authUrl, method: .post, parameters: parameters).responseJSON { response in
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
            AuthModel.accessToken = tokenModel?.access_token ?? ""
            return true
        } else {
            return false
        }
    }
    
    static func getAnimals(url: String, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(AuthModel.accessToken)",
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            print("getAnimals response json \( response )")
            print("getAnimals status code will be printed \(response.response?.statusCode)")
            let result = response.result
            switch result {
            case .success(let json):
                print("success part getAnimals \(json)")
                let statusCode = response.response?.statusCode ?? 0
                let httpStatusCode = HTTPStatusCode(rawValue: statusCode)
                handleAnimalsHttpUrlResponse(url: url, json: json, httPStatusCode: httpStatusCode) { response in
                    completion(response)
                }
            case .failure(let error):
                print("failure part getAnimals \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    
    static func handleAnimalsHttpUrlResponse(url: String, json: Any, httPStatusCode: HTTPStatusCode?, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        switch httPStatusCode {
        case .ok:
            print("getAnimals status code is 200")
            let animalsResponse = handleGetAnimalsSuccessCase(json: json)
            completion(animalsResponse)
        case .unauthorized:
            print("getAnimals status code is 401")
            handleExpiredToken(url: url) { response in
                completion(response)
            }
        default:
            print("default case switch ")
            completion(nil)
        }

    }
    
    static func handleGetAnimalsSuccessCase(json: Any) -> AnimalsResponse? {
        let newJson = json as? JSON ?? ["": ""]
        print("handleGetAnimalsSuccessCase \(newJson)")
        let animalsResponse: AnimalsResponse? = AnimalsResponse(json: newJson)
        print("getAnimals animal response will be printed \(animalsResponse)")
        return animalsResponse
    }
    
    static func handleExpiredToken(url: String, completion: @escaping(_ response: AnimalsResponse?) -> Void) {
        NetworkManager.getToken { success in
            if success {
                getAnimals(url: url) { response in
                    completion(response)
                }
            } else {
                completion(nil)
            }
        }
    }
    
}