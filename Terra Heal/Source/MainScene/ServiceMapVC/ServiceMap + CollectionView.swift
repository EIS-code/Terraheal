//
//  ServiceMap + CollectionView.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 08/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CollectionView Methods
extension ServiceMapVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    // MARK: UICollectionViewDataSource
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ServiceCell.nib()
            , forCellWithReuseIdentifier: ServiceCell.name)
        
        cltForCollapseView.backgroundColor = UIColor.themePrimaryLightBackground
        cltForCollapseView.isUserInteractionEnabled = true
        cltForCollapseView.showsVerticalScrollIndicator = false
        cltForCollapseView.showsHorizontalScrollIndicator = false
        cltForCollapseView.isPagingEnabled = true
        cltForCollapseView.delegate = self
        cltForCollapseView.dataSource = self
        cltForCollapseView.register(ServiceCollapseCell.nib()
            , forCellWithReuseIdentifier: ServiceCollapseCell.name)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cltForCollapseView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollapseCell.name, for: indexPath) as! ServiceCollapseCell
            cell.layoutIfNeeded()
            cell.setData(data: self.arrForServices[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.name, for: indexPath) as! ServiceCell
            cell.layoutIfNeeded()
            cell.setData(data: self.arrForServices[indexPath.row])
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == cltForCollapseView {
            self.upDialogAnimation()
            self.transitionAnimator?.startAnimation()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
                if let ip = collectionView.indexPathForItem(at: center) {
                   self.currentIndex = ip.row
                   self.setCenterDataFor(index: self.currentIndex)
                }
    }
    
    
}
