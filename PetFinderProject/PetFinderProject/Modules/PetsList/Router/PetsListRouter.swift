//
//  PetsListRouter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit


class PetsListRouter {
    
    func goToAnimalDetails(animalViewModel: AnimalViewModel?) {
        let currentNC = UIApplication.topViewController()?.navigationController
        let sb = UIStoryboard(name: Constants.StoryboardNames.petDetailsSB.rawValue, bundle: nil)
        let destVC = sb.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.petDetailsVC.rawValue) as! PetDetailsViewController
        destVC.animalViewModel = animalViewModel
        currentNC?.pushViewController(destVC, animated: true)

    }
}
