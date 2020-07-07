//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import GoogleMaps


struct ServiceDetail {
    var name:String = ""
    var address:String = ""
    var numberOfServices: String = ""
    var serviceDetails: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis urna id volutpat lacus laoreet. Mauris vitae ultricies leo integer malesuada. Ac odio tempor orci dapibus ultrices in. Egestas diam in arcu cursus euismod. Dictum fusce ut placerat orci nulla. Tincidunt ornare massa eget egestas purus viverra accumsan in nisl. Tempor id eu nisl nunc mi ipsum faucibus. Fusce id velit ut tortor pretium. Massa ultricies mi quis hendrerit dolor magna eget. Nullam eget felis eget nunc lobortis."
    var latitude: String = ""
    var longitude: String = ""
    func getCoordinatte() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude.toDouble, longitude: self.longitude.toDouble)
    }
    
}

class ServiceMapVC: MainVC {
    
    
    @IBOutlet weak var btnCheckService: ThemeButton!
    @IBOutlet weak var btnBook: ThemeButton!
    @IBOutlet weak var lblAddressTitle: ThemeLabel!
    @IBOutlet weak var lblAddress: ThemeLabel!
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var vwService: UIView!
    @IBOutlet weak var ivService: PaddedImageView!
    @IBOutlet weak var btnKm: ThemeButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnMyLocation: UIButton!
    var currentMarker: GMSMarker? = nil
    var path: GMSPolyline =   GMSPolyline.init()
    var currentIndex: Int = 0
    // MARK: Object lifecycle
    var arrForServices: [ServiceDetail] = [
        ServiceDetail(name: "terra heal massage center", address: "Lorem ipsum dolor sit,lisbon, portugal -25412", numberOfServices: "25",latitude: "22.35",longitude: "70.90"),
        ServiceDetail(name: "terra heal massage center 2", address: "Lorem ipsum dolor sit,lisbon, portugal -25112", numberOfServices: "35",  latitude: "22.50",longitude: "70.50"),
        ServiceDetail(name: "terra heal massage center 3", address: "Lorem ipsum dolor sit,lisbon, portugal -25212", numberOfServices: "15", latitude: "22.70",longitude: "70.30")]
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.currentMarker = GMSMarker.init()
        self.setupMapView(mapView: self.mapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.btnBook?.setHighlighted(isHighlighted: false)
            self.btnCheckService?.setHighlighted(isHighlighted: true)
            self.mapView.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.vwService.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.btnKm.setHighlighted(isHighlighted: true)
            
            self.ivService.setRound()
            
        }
    }
    
    private func initialViewSetup() {
        self.lblAddressTitle?.text = "Home".localized()
        self.lblAddressTitle?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblAddress?.text = "Lorem Ipsum, Lisbon, portugal 12451.".localized()
        self.lblAddress?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnBook.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnBook.setTitle("BTN_BOOK_HERE".localized(), for: .normal)
        self.btnCheckService.setTitle("BTN_CHECK_SERVICE".localized(), for: .normal)
        self.btnCheckService.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.setupCollectionView(collectionView: self.collectionView)
    }
    
    
    // MARK: Action Buttons
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCheckServiceTapped(_ sender: Any) {
        //Common.appDelegate.loadRegisterVC()
        self.openServiceSelectionDialog()
    }
    @IBAction func btnBookhereTapped(_ sender: Any) {
        //Common.appDelegate.loadHomeVC()
    }
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        var arrForCoordinate: [CLLocationCoordinate2D] = [self.currentMarker!.position]
        for center in arrForServices {
            arrForCoordinate.append(center.getCoordinatte())
        }
        self.mapView.focusMap(locations: arrForCoordinate)
    }
    
    // MARK: Other Functions
    func openServiceSelectionDialog() {
        let serviceSelectionDialog: CustomServiceSelectionDialog  = CustomServiceSelectionDialog.fromNib()
        serviceSelectionDialog.initialize(title: arrForServices[currentIndex].name, buttonTitle: "BTN_PROCEED".localized())
        
        
        serviceSelectionDialog.show(animated: true)
        serviceSelectionDialog.onBtnCancelTapped = {
            [weak serviceSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            serviceSelectionDialog?.dismiss()
        }
        serviceSelectionDialog.onBtnDoneTapped = {
            [weak serviceSelectionDialog, weak self]  in
            guard let self = self else { return } ; print(self)
            serviceSelectionDialog?.dismiss()
            let serviceDetailVC =  Common.appDelegate.loadServiceDetailVC(navigaionVC: self.navigationController)
            serviceDetailVC.serviceDetail = self.arrForServices[self.currentIndex]
        }
        
       
    }
}


// MARK: - CollectionView Methods
extension ServiceMapVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    // MARK: UICollectionViewDataSource
    
    private func setupCollectionView(collectionView:  UICollectionView) {
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


extension ServiceMapVC :GMSMapViewDelegate {
    
    func setupMapView(mapView: GMSMapView) {
        mapView.delegate = self;
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        mapView.padding = UIEdgeInsets.init(top: 20, left: 20, bottom: 60, right: 20)
        mapView.animate(toLocation: CLLocationCoordinate2D.init(latitude: 22.30, longitude: 70.80))
        mapView.animate(toZoom: 15)
        self.mapView.setCurrentMarker(marker: self.currentMarker!, location: CLLocationCoordinate2D.init(latitude: 22.30, longitude: 70.80))
        self.setMassageCenterMarker()
        self.mapView.applyStyle()
        self.mapView.focusMap(locations: [self.currentMarker!.position,arrForServices[self.currentIndex].getCoordinatte()])
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        mapView.updateLine(polyline: path)
    }
    
    func setMassageCenterMarker() {
        for center in arrForServices {
            self.mapView.setMassageCenterMarker(marker: GMSMarker.init(), image: UIImage.init(named: "asset-center")!, location: center.getCoordinatte())
        }
    }
}
