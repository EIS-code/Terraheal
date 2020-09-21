//
//  MainVC + CollectionView.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 11/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CollectionView Methods
extension MyFavVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(LocationServiceCltCell.nib()
            , forCellWithReuseIdentifier: LocationServiceCltCell.name)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationServiceCltCell.name, for: indexPath) as! LocationServiceCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       // self.openServiceDurationSelection(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }
    
    
}

extension MyFavVC {
    func getServiceCenterDetail() {
        AppWebApi.massageCenterDetail { (response) in
            if ResponseModel.isSuccess(response: response) {
                for data in response.serviceList {
                    self.arrForData.append(data)
                    self.collectionVw.reloadData()
                }
            }
        }
    }
}


