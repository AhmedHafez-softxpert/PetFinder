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

struct AnimalPhoto: Codable {
    let small, medium, large, full: String?
    
    init?(json: JSON) {
        self.small = "small" <~~ json
        self.medium = "medium" <~~ json
        self.large = "large" <~~ json
        self.full = "full" <~~ json
    }
    
    
}


struct Animal: Codable, JSONDecodable {
    var description: String?
    var name: String?
    var type: String?
    var gender: String?
    var photos: [AnimalPhoto?]?
    var mixed: Bool?
    
    init?(json: JSON) {
        self.description = "description" <~~ json
        self.name = "name" <~~ json
        self.type = "type" <~~ json
        self.gender = "gender" <~~ json
        self.photos = "photos" <~~ json
        self.mixed = "breeds.mixed" <~~ json
    }
}


struct AnimalsResponse: Codable {
    let animals: [Animal]?
//    let pagination: Pagination
    
    init?(json: JSON) {
        self.animals = "animals" <~~ json
    }
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
