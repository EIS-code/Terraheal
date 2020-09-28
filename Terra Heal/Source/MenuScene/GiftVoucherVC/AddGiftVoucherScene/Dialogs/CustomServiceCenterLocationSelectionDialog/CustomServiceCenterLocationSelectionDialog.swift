//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit
import GoogleMaps


class CustomServiceCenterLocationSelectionDialog: ThemeBottomDialogView {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var vwServiceDialog: UIView!
    @IBOutlet weak var ivService: PaddedImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var vwService: UIView!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var lblLocation: ThemeLabel!
    @IBOutlet weak var btnChange: ThemeButton!
    @IBOutlet weak var lblLocationValue: ThemeLabel!
    
    var onBtnDoneTapped: ((_ data: ServiceCenterDetail) -> Void)? = nil
    var arrForServices: [ServiceCenterDetail] = []
    var arrForServicesMarker: [GMSMarker] = []
    var arrForForLocationData: [PricingLocation] = []
    var currentMarker: GMSMarker? = nil
    var path: GMSPolyline =   GMSPolyline.init()
    var currentIndex: Int = 0
    var selectedLocation: PricingLocation? = nil
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
        self.wsGetLocationList()
        self.lblLocation.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblLocationValue.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.currentMarker = GMSMarker.init()
        self.setupMapView(mapView: self.mapView)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setupCollectionView()
        self.setDataForStepUpAnimation(data: [0.95])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.reloadData {
            self.mapView.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.vwServiceDialog.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.ivService.setRound()
            self.vwSearch.setRound(withBorderColor: .clear, andCornerRadious: self.vwSearch.bounds.height/2.0, borderWidth: 1.0)
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(self.arrForServices[self.currentIndex]);
        }
    }
    
    func setData() {
        self.collectionView.reloadData()
        self.setCenterDataFor(index: 0)
    }
    @IBAction func btnChangeTapped(_ sender: Any) {
        self.btnChange.isEnabled = false
        self.openLocationSelectionDialog()
    }
    
    func openLocationSelectionDialog() {
        var locationData: [CustomDataForTable] = []
        locationData.removeAll()
        for data in arrForForLocationData {
            locationData.append(data.toViewModel())
        }
        let locationPickerAlert: CustomTableDataSelectionDialog = CustomTableDataSelectionDialog.fromNib()
        locationPickerAlert.initialize(title:"Select Location", buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        locationPickerAlert.setDataSource(dataList: locationData)
        locationPickerAlert.show(animated: true)
        locationPickerAlert.onBtnCancelTapped = { [weak locationPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            locationPickerAlert?.dismiss()
            self.btnChange.isEnabled = true
        }
        locationPickerAlert.onBtnDoneTapped = { [weak locationPickerAlert, weak self] (data) in
            guard let self = self else { return } ; print(self)
            locationPickerAlert?.dismiss()
            self.btnChange.isEnabled = true
            if let locationSelection: PricingLocation = self.arrForForLocationData.first(where: { (location) -> Bool in
                location.id == data.id
            })
            {
                self.selectedLocation = locationSelection
                self.setLocationData(location: locationSelection)
                self.getMassageCenter()
            }
            
        }
    }
}


// MARK: - CollectionView Methods

extension CustomServiceCenterLocationSelectionDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
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

extension CustomServiceCenterLocationSelectionDialog : GMSMapViewDelegate {
    
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

extension CustomServiceCenterLocationSelectionDialog {
    func wsGetLocationList() {
        Loader.showLoading()
        AppWebApi.locationList() { (response) in
            self.arrForForLocationData.removeAll()
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.locationList {
                    self.arrForForLocationData.append(data)
                }
            }
            if let location = self.arrForForLocationData.first {
                self.selectedLocation = location
                self.setLocationData(location: location)
                self.getMassageCenter()
            }
            
        }
    }
    
    func getMassageCenter() {
        Loader.showLoading()
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
            Loader.hideLoading()
        }
    }
    
    func setLocationData(location:PricingLocation) {
        self.lblLocationValue.setTextWithAnimation(text: location.name)
    }
}
