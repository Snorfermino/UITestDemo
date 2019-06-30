//
//  UIView.swift
//  My Contractor
//
//  Created by Phung Du on 3/20/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import SnapKit
public enum Dimension {
    case w
    case h
    case x
    case y
}
extension UIView {
    func fit(with duration: TimeInterval = 0.0, subView: UIView?) {
        guard let subView = subView else { return }
        subView.alpha = 0
        addSubview(subView)
        UIView.animate(withDuration: duration) {
            subView.alpha = 1
            subView.snp.makeConstraints { $0.edges.equalTo(self.safeArea.edges) }
        }
    }

    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
