//
//  BaseViewController.swift
//  My Contractor
//
//  Created by Phung Du on 3/19/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import AVFoundation
import EZSwiftExtensions
import SnapKit
import UIKit

class BaseViewController: UIViewController {
    // MARK: - Managers and Services
    lazy var vcManager = VCManager.sharedInstance

    // MARK: - UI/UX Elements
    var imgViewBG: UIImageView!
    var btnBack: UIButton!

    // // MARK: - Constants and Variables
    let screenSize = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        navBar?.isHidden = true
    }


    func setupView() {
        self.view.backgroundColor = .white
        btnBack = UIButton()
        btnBack.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(btnBack)
    }

    func setupConstraints() {
        let imgViewIconBack = UIImageView(image: #imageLiteral(resourceName: "ic_arrow_forward"))
        imgViewIconBack.accessibilityIdentifier = "icBack"
        view.addSubview(imgViewIconBack)
        imgViewIconBack.snp.makeConstraints {
            $0.top.equalTo(view.safeArea.top).offset(screenSizeRatio(dimension: .h, with: 45))
            $0.left.equalTo(view.safeArea.left).offset(screenSizeRatio(dimension: .w, with: 20))
            $0.width.height.equalTo(screenSizeRatio(dimension: .w, with: 16))
        }

        btnBack.snp.makeConstraints {
            $0.centerX.centerY.equalTo(imgViewIconBack)
            $0.width.equalTo(screenSizeRatio(dimension: .w, with: 50))
            $0.height.equalTo(screenSizeRatio(dimension: .h, with: 50))
        }
    }

    func screenSizeRatio(dimension: Dimension, with constant: CGFloat) -> CGFloat {
        var finalConstant: CGFloat = 0
        if #available(iOS 11.0, *) {
            switch dimension {
            case .w: finalConstant = constant * screenSize.w / 375
            case .h: finalConstant = constant * screenSize.h / 667
            default: break
            }
        }  else {
            switch dimension {
            case .w: finalConstant = constant * screenSize.w / 375
            case .h: finalConstant = constant * screenSize.h / 667
            default: break
            }
        }
        return finalConstant
    }

    func hideBackButton() {
        btnBack.isHidden = true
        view.subviews.forEach {
            if $0.accessibilityIdentifier == "icBack" {
                $0.isHidden = true
            }
        }
    }

    func setupNavigationBar(title: String, haveBack: Bool? = false, rightBarItem: UIBarButtonItem? = nil) {
        self.navBar?.isHidden = false
        if haveBack! {
            let btnBack =  UIButton(type: .custom)
            btnBack.setImage(UIImage(named: "ic_arrow_forward"), for: .normal)
            btnBack.addTarget(self, action: #selector(back), for: .touchUpInside)
            btnBack.frame = CGRect(x: 0, y: 0, width: 45, height: 34)
            btnBack.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            let barButton = UIBarButtonItem(customView: btnBack)
            navigationItem.leftBarButtonItem = barButton
        }

        navBar?.isTranslucent = false
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()

        navigationItem.title = title
        guard let btnRightBar = rightBarItem else { return }
        navigationItem.rightBarButtonItem = btnRightBar
    }

    func clearNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    func showNeedLogin() {
        let alertVC = UIAlertController(title: "Warning", message: "User feature requires login", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "NO", style: .cancel))
        alertVC.addAction(UIAlertAction(title: "YES", style: .default) { action in
            let loginVC = LoginVC()
            self.vcManager.popToVC(loginVC, alternativeRoute: loginVC)
        })
        present(alertVC, animated: true)
    }

    func showError(_ title:String? = "Error",_ string: String? = "Error Occurred") {
        let alertVC = UIAlertController(title: title, message: string, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alertVC, animated: true)
    }

    func showErrorWithPopBack(_ title:String? = "Error",_ string: String? = "Error Occurred") {
        let alertVC = UIAlertController(title: title, message: string, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: { [weak self] action in
            self?.back()
        }))
        present(alertVC, animated: true)
    }

    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        }
    }

    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Camera access is denied",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                    // Handle
                })
            }
        })

        present(alertController, animated: true)
    }

    func showEmptyList() {
        let emptyView = UIImageView(image: #imageLiteral(resourceName: "img_backgroundID043"))
        view.fit(subView: emptyView)
        view.bringSubviewToFront(emptyView)
    }
}

// MARK: - Button Actions
extension BaseViewController {
    @objc func back() {
        vcManager.popVC()
    }

    @objc func dismissKb() {
        view.endEditing(true)
    }
}
