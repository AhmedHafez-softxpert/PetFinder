//
//  AppDelegate.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/21/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureRootViewController()
        return true
    }

    func configureRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let sb = UIStoryboard(name: "HomeScreen", bundle: nil)
        let destVC = sb.instantiateViewController(withIdentifier: "SearchPetsNavigationController") as! UINavigationController
        window!.rootViewController = destVC
        window!.makeKeyAndVisible()
    }


}

