//
//  OnBoardingVC.swift
//  My Contractor
//
//  Created by Phung Du on 3/19/19.
//  Copyright © 2019 CIDB. All rights reserved.
//
import IBAnimatable
import UIKit
import SnapKit

class OnBoardingVC: BaseViewController {
    // MARK: Variables
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private var pageControlViews: [UIView]!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "onBoarding"
        
        setupCollectionView()
        resetStateSteps()
        selectedStep(at: 0)
        
    }
    
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.register(UINib.init(nibName: "OnBoardingCell", bundle: nil), forCellWithReuseIdentifier: "OnBoardingCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.accessibilityIdentifier = "onBoardingCollectionView"
    }
    
    func resetStateSteps(){
        for view in pageControlViews{
            view.backgroundColor = UIColor(hexString: "DBDBDB")
            view.layer.cornerRadius = 0
            view.layer.borderColor = UIColor.clear.cgColor
            view.layer.borderWidth = 2
        }
    }
    
    func selectedStep(at index: Int){
        let view = pageControlViews[index]
        view.layer.cornerRadius = 2
        view.backgroundColor = UIColor.black
        view.layer.borderColor = UIColor.black.cgColor
    }

}

extension OnBoardingVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingCell", for: indexPath) as! OnBoardingCell
        
        switch indexPath.row {
        case 0:
            cell.config(mediumTitle: "ID_002_Welcome_Title".localized, largeTitle: "ID_002_My_Contractor".localized, subTitle: "ID_003_Welcome_Title".localized, image: UIImage(named: "img_Onboarding_1"))
        case 1:
            cell.config(mediumTitle: "ID_004_Medium_Title".localized, largeTitle: "ID_004_Large_Title".localized, subTitle: "ID_004_SubTitle".localized, image: UIImage(named: "img_Onboarding_2"))
        case 2:
            cell.config(mediumTitle: "ID_005_Medium_Title".localized, largeTitle: "ID_005_Large_Title".localized, subTitle: "ID_005_SubTitle".localized, image: UIImage(named: "img_Onboarding_3"))
        default: break
        }
        return cell
        
    }
    
}

extension OnBoardingVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        
        resetStateSteps()
        selectedStep(at: indexPath.row)

    }
}

// MARK: Button Action
extension OnBoardingVC {
    @IBAction private func didPressSkip() {
        // TODO: Add transition to Login Screen
        vcManager.rerouteVC(to: LoginVC())
        
    }
}

