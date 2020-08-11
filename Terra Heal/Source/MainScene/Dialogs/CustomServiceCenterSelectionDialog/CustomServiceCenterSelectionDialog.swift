//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit
import GoogleMaps


class CustomServiceCenterSelectionDialog: ThemeBottomDialogView {

  
      @IBOutlet weak var mapView: GMSMapView!
      @IBOutlet weak var vwServiceDialog: UIView!
      @IBOutlet weak var ivService: PaddedImageView!
      @IBOutlet weak var btnKm: ThemeButton!
      @IBOutlet weak var collectionView: UICollectionView!
      @IBOutlet weak var btnMyLocation: UIButton!
      @IBOutlet weak var vwService: UIView!
      @IBOutlet weak var hCltVw: NSLayoutConstraint!
     
     var onBtnDoneTapped: (() -> Void)? = nil
       var arrForServices: [ServiceCenterDetail] = []
       var arrForServicesMarker: [GMSMarker] = []
       var currentMarker: GMSMarker? = nil
       var path: GMSPolyline =   GMSPolyline.init()
       var currentIndex: Int = 0
    
        override func awakeFromNib() {
            super.awakeFromNib()
        }
    
    
    func initialize(title:String,buttonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        
    }

    override func initialSetup() {
        super.initialSetup()
        self.currentMarker = GMSMarker.init()
        self.setupMapView(mapView: self.mapView)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setupCollectionView()
        self.setDataForStepUpAnimation(data: [0.95])
        self.getMassageCenter()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.reloadData {
             self.mapView.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
                 self.vwServiceDialog.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
                 self.ivService.setRound()
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
               // self.onBtnDoneTapped!();
            }
    }
    func getMassageCenter() {
        AppWebApi.massageCenterList(params: ServiceCenter.RequestServiceCenterlist()) { (response) in
            self.arrForServices.removeAll()
            self.removeAllCenterMarker()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for i  in 0..<response.serviceCenterList.count {
                    let data = response.serviceCenterList[i]
                    self.arrForServices.append(data)
                    
                }
                self.createNewCenterMarkers()
                self.setData()
            }
        }
    }
    func setData() {
        self.collectionView.reloadData()
        self.setCenterDataFor(index: 0)
    }
    
    
}


// MARK: - CollectionView Methods

extension CustomServiceCenterSelectionDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
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
      /*  if collectionView == cltForCollapseView {
            self.upDialogAnimation()
            self.transitionAnimator?.startAnimation()
        }*/
        
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
    func setCenterDataFor(index:Int) {
           self.collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .centeredHorizontally, animated: true)
           self.mapView.focusMap(locations: [self.currentMarker!.position,self.arrForServicesMarker[index].position])
           self.mapView.drawPolyline(polyline: path, source: self.currentMarker!.position, destination: arrForServices[index].getCoordinatte())
       }
}

extension CustomServiceCenterSelectionDialog : GMSMapViewDelegate {
    
        func setupMapView(mapView: GMSMapView) {
            mapView.delegate = self;
            mapView.translatesAutoresizingMaskIntoConstraints = false
            mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
            mapView.padding = UIEdgeInsets.init(top: 20, left: 20, bottom: 60, right: 20)
            mapView.animate(toLocation: appSingleton.getCurrentCoordinate())
            mapView.animate(toZoom: 15)
            self.mapView.setCurrentMarker(marker: self.currentMarker!, location: appSingleton.getCurrentCoordinate())
            self.mapView.applyStyle()
        }
        
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
            
        }
        
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            mapView.updateLine(polyline: path)
        }
        
        func createNewCenterMarkers() {
            self.removeAllCenterMarker()
            for i  in 0..<arrForServices.count {
                let center: ServiceCenterDetail = self.arrForServices[i]
                let marker:GMSMarker = GMSMarker.init(position: center.getCoordinatte())
                marker.title  = center.name
                marker.map = self.mapView
                marker.userData = i
                self.arrForServicesMarker.append(GMSMarker.init(position: center.getCoordinatte()))
                self.mapView.setMassageCenterMarker(marker: marker, image: UIImage.init(named: "asset-center-maker")!, location: center.getCoordinatte())
            }
        }
        
        func removeAllCenterMarker() {
            for marker in self.arrForServicesMarker {
                marker.map = nil
            }
            self.arrForServicesMarker.removeAll()
        }
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            if let index = marker.userData as? Int {
                self.currentIndex = index
                self.setCenterDataFor(index: self.currentIndex)
            }
            return true
        }
}