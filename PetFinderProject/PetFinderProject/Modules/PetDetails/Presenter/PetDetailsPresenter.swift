//
//  PetDetailsPresenter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import Foundation


class PetDetailsPresenter {
    
    let view: PetDetailsInput
    let router: PetDetailsRouter
    
    init(view: PetDetailsInput, router: PetDetailsRouter) {
        self.view = view
        self.router = router
    }
}


extension PetDetailsPresenter: PetDetailsOutput {
    func viewDidLoad() {
        view.setupUI()
    }
    
    func didTapPetUrlButton() {
        print("did tap visit url button from presnter")
    }
    
    
}
