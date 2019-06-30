//
//  OnBoardingCell.swift
//  Contractor4u
//
//  Created by Khoi Nguyen on 5/31/19.
//  Copyright © 2019 CIDB. All rights reserved.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {

    @IBOutlet private weak var lblMediumTitle: UILabel!
    @IBOutlet private weak var lblLargeTitle: UILabel!
    @IBOutlet private weak var lblSubtitle: UILabel!
    
    @IBOutlet private weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
    }
    
    func config(mediumTitle: String?, largeTitle: String?, subTitle: String?, image: UIImage?){
        lblMediumTitle.text = mediumTitle
        lblLargeTitle.text = largeTitle
        lblSubtitle.text = subTitle
        
        imgView.image = image
        
    }

}
