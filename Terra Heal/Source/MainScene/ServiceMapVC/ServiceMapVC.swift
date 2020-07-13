//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import GoogleMaps


struct ServiceCenterDetail {
    var name:String = ""
    var address:String = ""
    var numberOfServices: String = ""
    var serviceDetails: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis urna id volutpat lacus laoreet. Mauris vitae ultricies leo integer malesuada. Ac odio tempor orci dapibus ultrices in. Egestas diam in arcu cursus euismod. Dictum fusce ut placerat orci nulla. Tincidunt ornare massa eget egestas purus viverra accumsan in nisl. Tempor id eu nisl nunc mi ipsum faucibus. Fusce id velit ut tortor pretium. Massa ultricies mi quis hendrerit dolor magna eget. Nullam eget felis eget nunc lobortis."
    var latitude: String = ""
    var longitude: String = ""
    func getCoordinatte() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude.toDouble, longitude: self.longitude.toDouble)
    }
    var servicesList: [ServiceDetail]
    
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
    var requestBooking: CurrentBooking = CurrentBooking.shared
    var sheetCoordinator: UBottomSheetCoordinator!
    // MARK: Object lifecycle
    var arrForServices: [ServiceCenterDetail] = [
        ServiceCenterDetail(name: "terra heal massage center", address: "Lorem ipsum dolor sit,lisbon, portugal -25412", numberOfServices: "25",latitude: "22.35",longitude: "70.90", servicesList: []),
        ServiceCenterDetail(name: "terra heal massage center 2", address: "Lorem ipsum dolor sit,lisbon, portugal -25112", numberOfServices: "35",  latitude: "22.50",longitude: "70.50", servicesList: []),
        ServiceCenterDetail(name: "terra heal massage center 3", address: "Lorem ipsum dolor sit,lisbon, portugal -25212", numberOfServices: "15", latitude: "22.70",longitude: "70.30", servicesList: [])]
    
    
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
        self.openServiceSelectionDialog()
        
    }
    @IBAction func btnBookhereTapped(_ sender: Any) {
        self.openSessionSelectionDialog()

    }
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
        var arrForCoordinate: [CLLocationCoordinate2D] = [self.currentMarker!.position]
        for center in arrForServices {
            arrForCoordinate.append(center.getCoordinatte())
        }
        self.mapView.focusMap(locations: arrForCoordinate)
    }
    
    
    
}

// MARK: Dialogs
extension ServiceMapVC {
    
    
    
    func openReciepentMassageDetailVCDialog() {
        
        let reciepentMassageDetailVC: ReciepentMassageDetailVC  = ReciepentMassageDetailVC.fromNib()
        guard sheetCoordinator == nil else {return}
        sheetCoordinator = UBottomSheetCoordinator(parent: self)
        reciepentMassageDetailVC.sheetCoordinator = sheetCoordinator
        reciepentMassageDetailVC.onBtnNextSelectedTapped = { [weak self,  weak reciepentMassageDetailVC] (arrForReceipents) in
             guard let self = self else { return } ; print(self)
            self.requestBooking.reciepentData = arrForReceipents
            reciepentMassageDetailVC?.dismissAction()
            reciepentMassageDetailVC?.removeFromParent()
            self.sheetCoordinator = nil
            self.openDateTimeSelectionDialog()
        }
        reciepentMassageDetailVC.onBtnBackTapped = { [weak self, weak reciepentMassageDetailVC] in
        guard let self = self else { return } ; print(self)
            self.requestBooking.reciepentData = []
            reciepentMassageDetailVC?.dismissAction()
            reciepentMassageDetailVC?.removeFromParent()
            self.sheetCoordinator = nil
        }
        sheetCoordinator.addSheet(reciepentMassageDetailVC, to: self, didContainerCreate: { container in
            container.roundCorners(corners: [.topLeft, .topRight], radius: 40)
            
        })
      }
    
    func openTextViewPicker() {
           let alert: TextViewDialog = TextViewDialog.fromNib()
           alert.initialize(title: "booking notes"
               , data: self.requestBooking.bookingNotes, buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
           alert.show(animated: true)
           alert.onBtnCancelTapped = {
               [weak alert, weak self] in
               guard let self = self else {return}; print(self)
               alert?.dismiss()
           }
           alert.onBtnDoneTapped = {
               [weak alert, weak self] (description) in
               guard let self = self else { return } ; print(self)
               alert?.dismiss()
               self.requestBooking.bookingNotes = description
             self.requestBooking.serviceCenterDetail = self.arrForServices[self.currentIndex]
               Common.appDelegate.loadReviewAndBookVC(navigaionVC: self.navigationController)
           }
       }

    
    func openServiceSelectionDialog() {
        let serviceSelectionDialog: CustomServiceSelectionDialog  = CustomServiceSelectionDialog.fromNib()
        serviceSelectionDialog.initialize(title: arrForServices[currentIndex].name, buttonTitle: "BTN_BOOK_HERE".localized())
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
            self.openSessionSelectionDialog()
        }
    }
    
    func openDateTimeSelectionDialog() {
        let dateTimeSelectionDialog: DateTimeDialog  = DateTimeDialog.fromNib()
        dateTimeSelectionDialog.initialize(title: "DATE_DIALOG_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        dateTimeSelectionDialog.show(animated: true)
        dateTimeSelectionDialog.onBtnCancelTapped = {
            [weak dateTimeSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            dateTimeSelectionDialog?.dismiss()
        }
        dateTimeSelectionDialog.onBtnDoneTapped = {
            [weak dateTimeSelectionDialog, weak self]  (millis)in
            guard let self = self else { return } ; print(self)
            dateTimeSelectionDialog?.dismiss()
            print(Date.milliSecToDate(milliseconds: millis, format: "dd-MM-yyyy HH:mm"))
            self.requestBooking.date = millis
            self.openTextViewPicker()
        }
    }
    
    func openSessionSelectionDialog() {
        let sessionSelectionDialog: SessionDialog  = SessionDialog.fromNib()
        sessionSelectionDialog.initialize(title: "SESSION_TYPE_TITLE".localized(), buttonTitle: "".localized(), cancelButtonTitle: "BTN_BACK".localized())
        sessionSelectionDialog.setDataSource(data: SessionDetail.getDemoArray())
        sessionSelectionDialog.show(animated: true)
        sessionSelectionDialog.onBtnCancelTapped = {
            [weak sessionSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            sessionSelectionDialog?.dismiss()
        }
        sessionSelectionDialog.onBtnDoneTapped = {
            [weak sessionSelectionDialog, weak self] (session) in
            guard let self = self else { return } ; print(self)
            sessionSelectionDialog?.dismiss()
            self.requestBooking.session = session
            self.openReciepentMassageDetailVCDialog()
        }
    }
    
   
}



