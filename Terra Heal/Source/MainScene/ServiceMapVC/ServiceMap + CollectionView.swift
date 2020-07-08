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
    
     func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ServiceCell.nib()
            , forCellWithReuseIdentifier: ServiceCell.name)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.name, for: indexPath) as! ServiceCell
        cell.layoutIfNeeded()
        cell.setData(data: self.arrForServices[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size - 10, height: collectionView.bounds.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = collectionView.indexPathForItem(at: center) {
            self.currentIndex = ip.row
            
            self.mapView.focusMap(locations: [self.currentMarker!.position,arrForServices[self.currentIndex].getCoordinatte()])
            self.mapView.drawPolyline(polyline: path, source: self.currentMarker!.position, destination: arrForServices[self.currentIndex].getCoordinatte())
        }
    }
    
}
