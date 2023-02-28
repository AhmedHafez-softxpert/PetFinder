//
//  PetsListRouter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/23/23.
//

import UIKit


class PetsListRouter {
    
    func goToAnimalDetails(animalViewModel: AnimalViewModel?) {
        // should take navigation controller and animal view model to pass it
        print("goToAnimalDetails called from PetsListRouter")
        let currentNC = UIApplication.topViewController()?.navigationController
        print("PetsListRouter currentVC \(currentNC)")
        let sb = UIStoryboard(name: "PetDetails", bundle: nil)
        let destVC = sb.instantiateViewController(withIdentifier: "PetDetailsViewController") as! PetDetailsViewController
        destVC.animalViewModel = animalViewModel
        currentNC?.pushViewController(destVC, animated: true)

    }
}
