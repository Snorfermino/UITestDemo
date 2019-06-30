//
//  LanguageSelectionView.swift
//  My Contractor
//
//  Created by Phung Du on 3/19/19.
//  Copyright © 2019 CIDB. All rights reserved.
//
import SnapKit
import UIKit
enum LanguageID {
    case us
    case ml
}
protocol LanguageSelectionViewDelegate {
    func didSelect(language: LanguageID)
}
class LanguageSelectionView: UIView {
    // MARK: - Constants and Variables
    var imgViewRadio: UIImageView!
    var radio: RadioButton!
    var lbLanguage: UILabel!
    var isSelected = false
    var delegate: LanguageSelectionViewDelegate?
    lazy var languageIdentifier = LanguageID.us
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: UI Functions
    private func setupView() {
        imgViewRadio = UIImageView(image: #imageLiteral(resourceName: "ic_miniIncompletedID001"))
        radio = RadioButton()
        lbLanguage = UILabel()
        radio.outerCircleColor = UIColor(rgb: 0x3D56F5)
        radio.innerCircleCircleColor = UIColor(rgb: 0x3D56F5)
        addSubview(imgViewRadio)
        addSubview(lbLanguage)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressed)))
        imgViewRadio.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.left.equalTo(self).offset(12)
            $0.width.height.equalTo(20)
        }

        lbLanguage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.left.equalTo(imgViewRadio.snp.right).offset(20)
        }
    }

    // MARK: - Setup
    func setLabelText(_ text: String) {
        lbLanguage.text = text
    }

    func setLanguageIdentifier(_ langId: LanguageID) {
        languageIdentifier = langId
    }

    func setRadioState(isSelected: Bool) {
        radio.isSelected = isSelected
    }

    @objc func didPressed() {
        delegate?.didSelect(language: languageIdentifier)
    }
}
