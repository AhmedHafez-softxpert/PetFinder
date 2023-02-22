//
//  SearchPetsViewController.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit
import Alamofire
import Gloss

struct AuthModel: Codable {
    var token_type: String?
    var expires_in: Double?
    var access_token: String?
    
    init?(json: JSON) {
        self.token_type = "token_type" <~~ json
        self.expires_in = "expires_in" <~~ json
        self.access_token = "access_token" <~~ json

    }
    
}


class SearchPetsViewController: UIViewController {

    @IBOutlet weak var petsTableView: UITableView!
    
    @IBOutlet weak var petsFilterCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPetsTable()
//        getToken()
    }
    


    
    func setupPetsTable() {
        petsTableView.dataSource = self
        petsTableView.delegate = self
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
