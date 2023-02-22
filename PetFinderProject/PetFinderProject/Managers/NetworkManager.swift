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
    
    
    static func getToken() {
        
        let parameters: [String: Any] = [
            "grant_type": "client_credentials",
            "client_id": "\(Constants.apiKey)",
            "client_secret": "\(Constants.secretKey)"
        ]
        
    
        
        let authUrl = "https://api.petfinder.com/v2/oauth2/token"
//        AF.request(authUrl, method: .post, parameters: parameters).response { respone in
//            print("response will be printed")
//            debugPrint(respone)
//            let result  = respone.result
//            switch result {
//            case .failure(let error):
//                print("dailure part get token \(error.localizedDescription)")
//            case .success(let data):
//                debugPrint("success part get token \(data)")
//                let dataString = String(data: data!, encoding: String.Encoding.utf8)
//                print("data string will be printed \(dataString)")
////                var test : AuthModel? =
//
//
//            }
//
//        }
        
        AF.request(authUrl, method: .post, parameters: parameters).responseJSON { response in
            print("response json \( response )")
            let result = response.result
            switch result {
            case .success(let json):
                print("success part get token \(json)")
                let newJson = json as? JSON ?? ["": ""]
                let authModel: AuthModel? = AuthModel(json: newJson)
                print("autj model will be printed \(authModel)")
                
            case .failure(let error):
                print("failure part get token \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
}
