//
//  SearchPetsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit
import Alamofire
import Gloss

struct TokenModel: Codable {
    var access_token: String?
    
    init?(json: JSON) {
        self.access_token = "access_token" <~~ json
    }
    
}

struct AuthModel {
    static var accessToken: String = ""
}


struct Animal: Codable {
    
}


class SearchPetsViewController: UIViewController {
    
    @IBOutlet weak var petsFilterCollectionView: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getToken()
        getAnimals()
        
        
        
    }
    
//    func getAnimalsNew() async {
//        
//        let emptyToken = Helpers.isTokenEmpty()
//        if emptyToken {
//            let result = await NetworkManager.getToken()
//            if result {
//                // success get token
//                let result = await NetworkManager.getAnimals()
//            }
//        } else {
//            let result = await NetworkManager.getAnimals()
//            let statusCode = result.statusCode
//            switch statusCode {
//            case 401:
//                print("getAnimalsNew invalid token result")
//            case 200:
//                print("getAnimalsNew status code 200")
//            default:
//                print("getAnimalsNew deafult case status code")
//            }
//        }
//        
//        
//    }
    
    func getAnimals() {
        NetworkManager.getAnimals { success in
            print("result from vc \(success)")
        }
    }

}

//MARK: -> Tableview methods
extension SearchPetsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    
}
