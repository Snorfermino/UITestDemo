//
//  File.swift
//  My Contractor
//
//  Created by Phung Du on 3/20/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import UIKit

extension UIWindow {
    /// Convenience var for rootViewController
    var rootVC: UIViewController? {
        get { return rootViewController }
        set { rootViewController = newValue }
    }
}

// MARK: - Computed Properties
extension UINavigationController {
    var presentingVC: UIViewController? { return presentingViewController }
    var vcs: [UIViewController] { return viewControllers }
    var visibleVC: UIViewController? { return visibleViewController }
}

// MARK: - Convenience Functions
extension UINavigationController {
    convenience init(rootVC: UIViewController) {
        self.init(rootViewController: rootVC)
    }

    func popToRoot(animated: Bool = true) {
        popToRootViewController(animated: animated)
    }

    func pop(animated: Bool = true) {
        popViewController(animated: animated)
    }

    func push(_ pushedVC: UIViewController, animated: Bool = true) {
        pushViewController(pushedVC, animated: animated)
    }

    func backToViewController(vc: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element))" == "\(type(of: vc))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
