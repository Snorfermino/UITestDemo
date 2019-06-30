//
//  LoginVC.swift
//  My Contractor
//
//  Created by Phung Du on 3/22/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import IBAnimatable
import UIKit
import SnapKit

class LoginVC: BaseViewController {
    // MARK: - UI/UX Elements
    var btnCtnAsGuest: AnimatableButton!
    var btnForgotPw: AnimatableButton!
    var btnSignIn: AnimatableButton!
    var btnSignUp: AnimatableButton!
    var lbHello: UILabel!
    var lbSignInToYourAcc: UILabel!
    var lbDontHaveAccount: UILabel!
    var lbWrongEmailPw: UILabel!

    var imageViewHidePw: AnimatableImageView!

    var tfEmail: AnimatableTextField!
    var tfPw: AnimatableTextField!

    // MARK: - Constants and Variables
    lazy var isLoginInvalid = false
    lazy var username = ""
    lazy var password = ""
    // MARK: - Override functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBar?.isHidden = true
    }

    override func viewDidLoad() {
        view.accessibilityIdentifier = "loginVC"

    }

}
