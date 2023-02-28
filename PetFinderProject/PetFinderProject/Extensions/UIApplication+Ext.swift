//
//  UIApplication+Ext.swift
//  PetFinderProject
//
//  Created by SoftXpert on 2/28/23.
//

import UIKit


extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    static func getViewController<T>(of type: T.Type) -> UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {return nil}
        guard let vc = UIApplication.getAllChildren(in: rootViewController).filter({$0 is T}).first else {return nil}
        return vc
    }
    
    static private func getAllChildren(in parent: UIViewController) -> [UIViewController] {
        var children = [UIViewController]()
        for child in parent.children {
            children += getAllChildren(in: child)
            children.append(child)
        }
        return children
    }
}
