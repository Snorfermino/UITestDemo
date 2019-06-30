//
//  VCManager.swift
//  My Contractor
//
//  Created by Phung Du on 3/20/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import UIKit
class VCManager: NSObject {
    // MARK: - Constants and Variables
    var presentedNC: UINavigationController!

    static let sharedInstance = VCManager()

    override init() {
        super.init()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Public Helpers

    func popToRootVC(animated: Bool = true) {
        presentedNC.popToRoot(animated: animated)
    }

    func popToVC(_ vc: BaseViewController, alternativeRoute: BaseViewController? = nil) {
        let vcs = presentedNC.viewControllers
        let contained = vcs.contains {
            type(of: $0) == type(of: vc)
        }
        if contained {
            presentedNC.backToViewController(vc: vc)
        } else {
            guard let vc = alternativeRoute else { return }
            rerouteVC(to: vc)
        }
    }

    @objc func popVC(animated: Bool = true) {
        presentedNC.pop(animated: animated)
    }

    func pushVC(_ vc: BaseViewController) {
        presentedNC.push(vc, animated: true)
    }

    // MARK: - Signin, Signup and Signout
    func showLanguageSelectionVC() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        presentedNC = UINavigationController(rootVC: LanguageSelectionVC())
        presentedNC.navigationBar.isHidden = true
        appDelegate.window?.rootVC = presentedNC
    }

    func showVC(_ vc: BaseViewController ,_ withNav: Bool = false) {
        if withNav {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            presentedNC = UINavigationController(rootVC: vc)
            presentedNC.navigationBar.isHidden = true
            appDelegate.window?.rootVC = presentedNC
        } else {
            presentedNC.push(vc, animated: true)
        }
    }

    func showOnboardingVC() {
        let onboardingVC = OnBoardingVC(nibName: "OnBoardingVC", bundle: nil)
        presentedNC.push(onboardingVC, animated: true)
    }

    @objc func showLoginVC() {
        let loginVC = LoginVC()
        presentedNC.push(loginVC, animated: true)
    }

    func setupNavigationBar(title: String, haveBack: Bool? = false, rightBarItem: UIBarButtonItem? = nil) {
        presentedNC.navigationBar.isHidden = false
        if haveBack! {
            let btnBack =  UIButton(type: .custom)
            btnBack.setImage(UIImage(named: "ic_arrow_forward"), for: .normal)
            btnBack.addTarget(self, action: #selector(popVC), for: .touchUpInside)
            btnBack.frame = CGRect(x: 0, y: 0, width: 45, height: 34)
            let barButton = UIBarButtonItem(customView: btnBack)
            presentedNC.navigationItem.leftBarButtonItem = barButton
        }
        presentedNC.navigationBar.barTintColor = .red
        presentedNC.navigationItem.title = title
        guard let btnRightBar = rightBarItem else { return }
        presentedNC.navigationItem.rightBarButtonItem = btnRightBar
    }

    func rerouteVC(to vc: BaseViewController, _ animated: Bool = true) {
        //        popToRootVC(animated: false)
        presentedNC.setViewControllers([vc], animated: animated)
    }
}
