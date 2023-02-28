//
//  PetDetailsRouter.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import UIKit
import SafariServices


class PetDetailsRouter {
    
    func goBack() {
        let currentNavigationController = UIApplication.topViewController()?.navigationController
        currentNavigationController?.popViewController(animated: true)
    }
    
    func openSafariVC(url: String) {
        guard let url = URL(string: url) else {return}
        let currentNavigationController = UIApplication.topViewController()?.navigationController
        let safariVC = SFSafariViewController(url: url)
        currentNavigationController?.present(safariVC, animated: true, completion: nil)
    }
    
}
