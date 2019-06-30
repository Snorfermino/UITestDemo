//
//  LanguageSelectionVC.swift
//  My Contractor
//
//  Created by Phung Du on 3/19/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import IBAnimatable
import SnapKit
import UIKit

class LanguageSelectionVC: BaseViewController {
    // MARK: Variables
    var btnStarted: AnimatableButton!
    var lbWelcome: UILabel!
    var svLanguages: UIStackView!
    var radios: [RadioButton] = []
    var ivRadios: [UIImageView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "languageSelection"
        didSelect(language: .us)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    // MARK: UI Functions
    override func setupView() {
        self.view.backgroundColor = .white
        btnStarted = AnimatableButton(frame: CGRect(x: 68, y: 579, w: 240, h: 45))
        btnStarted.backgroundColor = .white
        btnStarted.setTitle("Let's start", for: .normal)
        btnStarted.accessibilityIdentifier = "btnGetStart"
        btnStarted.shadowOffset = CGPoint(x: 0, y: 0)
        btnStarted.shadowRadius = 5
        btnStarted.shadowOpacity = 0.3
        btnStarted.imageView?.contentMode = .scaleAspectFit

        svLanguages = UIStackView()

        btnStarted.addTarget(self, action: #selector(didTapStarted), for: .touchUpInside)

        svLanguages.axis = .vertical
        svLanguages.alignment = .center
        svLanguages.spacing = 40
        svLanguages.distribution = .equalSpacing

        lbWelcome = UILabel()
        lbWelcome.accessibilityIdentifier = "lbWelcome"
        lbWelcome.numberOfLines = 3
        lbWelcome.textAlignment = .left


        lbWelcome.text = "Welcome to\nMyContractor!"

        //Todo: Add language options
        let languageUS = LanguageSelectionView(frame: CGRect(x: 0, y: 0, w: 170, h: 20))
        let languageMalaysian = LanguageSelectionView(frame: CGRect(x: 0, y: 60, w: 170, h: 20))
        languageUS.setLabelText("US")
        languageUS.accessibilityIdentifier = "viewLangUS"
        languageUS.delegate = self
        languageUS.radio.tag = 1
        languageUS.imgViewRadio.tag = 1
        radios.append(languageUS.radio)
        ivRadios.append(languageUS.imgViewRadio)
        languageMalaysian.languageIdentifier = .ml
        languageMalaysian.setLabelText("Indo")
        languageMalaysian.accessibilityIdentifier = "viewLangMY"
        languageMalaysian.delegate = self
        languageMalaysian.radio.tag = 2
        languageMalaysian.imgViewRadio.tag = 2
        radios.append(languageMalaysian.radio)
        ivRadios.append(languageMalaysian.imgViewRadio)
        svLanguages.addSubview(languageUS)
        svLanguages.addSubview(languageMalaysian)

        view.addSubview(btnStarted)
        view.addSubview(lbWelcome)
        view.addSubview(svLanguages)
        setupConstraints()
    }

    override func setupConstraints() {
        btnStarted.snp.makeConstraints {
            $0.bottom.equalTo(view.safeArea.bottom).offset(screenSizeRatio(dimension: .h, with: -45))
            $0.centerX.equalTo(view)
            $0.width.equalTo(screenSizeRatio(dimension: .w, with: 240))
            $0.height.equalTo(screenSizeRatio(dimension: .h, with: 45))
        }
        btnStarted.cornerRadius = btnStarted.frame.height / 1.75

        lbWelcome.snp.makeConstraints {
            $0.top.equalTo(view.safeArea.top).offset(screenSizeRatio(dimension: .h, with: 45))
            $0.left.equalTo(view.safeArea.left).offset(screenSizeRatio(dimension: .w, with: 50))
        }

        let lbSelectYourLanguage = UILabel()
        lbSelectYourLanguage.text = "Select your language"

        view.addSubview(lbSelectYourLanguage)
        lbSelectYourLanguage.snp.makeConstraints {
            $0.top.equalTo(lbWelcome.snp.bottom).offset(screenSizeRatio(dimension: .h, with: 14))
            $0.left.equalTo(lbWelcome)
        }

        svLanguages.snp.makeConstraints {
            $0.top.equalTo(view.safeArea.top).offset(screenSizeRatio(dimension: .h, with: 300))
            $0.centerX.equalTo(view)
            $0.width.equalTo(screenSizeRatio(dimension: .w, with: 170))
            $0.height.equalTo(screenSizeRatio(dimension: .h, with: 80))
        }

    }
}

// MARK: - Button Actions
extension LanguageSelectionVC {
    @objc func didTap() {

    }

    @objc func didTapStarted() {
        vcManager.showOnboardingVC()
    }

    func injected(){
        viewDidLoad()
    }
}

extension LanguageSelectionVC: LanguageSelectionViewDelegate {
    func didSelect(language: LanguageID) {
        switch language {
        case .us:

            ivRadios.first { $0.tag == 1 }?.image = #imageLiteral(resourceName: "ic_miniCompletedID001")
            ivRadios.first { $0.tag == 2 }?.image = #imageLiteral(resourceName: "ic_miniIncompletedID001")
            radios.first { $0.tag == 1 }?.isSelected = true
            radios.first { $0.tag == 2 }?.isSelected = false
        case .ml:
            
            ivRadios.first { $0.tag == 1 }?.image = #imageLiteral(resourceName: "ic_miniIncompletedID001")
            ivRadios.first { $0.tag == 2 }?.image = #imageLiteral(resourceName: "ic_miniCompletedID001")
            radios.first { $0.tag == 1 }?.isSelected = false
            radios.first { $0.tag == 2 }?.isSelected = true
        }
    }
}
