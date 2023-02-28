//
//  PetDetailsPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import Foundation


class PetDetailsPresenter {
    
    let view: PetDetailInput
    let router: PetDetailsRouter
    
    init(view: PetDetailInput, router: PetDetailsRouter) {
        self.view = view
        self.router = router
    }
}
