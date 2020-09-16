//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import GoogleMaps

class ServiceMapVC: BaseVC {
    
    
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var btnCheckService: ThemeButton!
    @IBOutlet weak var btnBook: RoundedBorderButton!
    @IBOutlet weak var lblAddressTitle: ThemeLabel!
    @IBOutlet weak var lblAddress: ThemeLabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var vwServiceDialog: UIView!
    @IBOutlet weak var ivService: PaddedImageView!
    @IBOutlet weak var btnKm: ThemeButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnMyLocation: UIButton!
    @IBOutlet weak var vwService: UIView!
    @IBOutlet weak var hCltVw: NSLayoutConstraint!
    @IBOutlet weak var vwForCollapseView: UIView!
    @IBOutlet weak var cltForCollapseView: UICollectionView!
    @IBOutlet weak var vwBottomButtons: UIView!
    @IBOutlet weak var hCltCollapseView: NSLayoutConstraint!
    
    
    var arrForServices: [ServiceCenterDetail] = []
    var arrForServicesMarker: [GMSMarker] = []
    var currentMarker: GMSMarker? = nil
    var path: GMSPolyline =   GMSPolyline.init()
    var currentIndex: Int = 0
    
    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0
    var animatingCell: ServiceCell!
    var targetAnimatingCell: ServiceCell!
    var sessionSelectionDialog: SessionDialog!
    var recipentMassageManageDialog: RecipentMassageManageDialog!
    var dialogForAccessory: AccessorySelectionDialog!
    var dateTimeSelectionDialog: DateTimeDialog!
    var textViewDialog: TextViewDialog!
    var languagePicker: CustomLanguagePicker!
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
        self.wsGetMassagePreferenceList()
        self.initialViewSetup()
        self.currentMarker = GMSMarker.init()
        self.setupMapView(mapView: self.mapView)
        self.addExpandAnimationPanGesture(view: self.vwService)
        self.addCollapseAnimationPanGesture(view: self.vwForCollapseView)
        self.transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.getMassageCenter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.collectionView.reloadData {
                let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
                self.hCltVw.constant = height
                self.view.layoutIfNeeded()
            }
            self.cltForCollapseView.reloadData {
                let height = self.cltForCollapseView.collectionViewLayout.collectionViewContentSize.height
                self.hCltCollapseView.constant = height
                self.view.layoutIfNeeded()
            }
            self.mapView.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.vwServiceDialog.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.vwForCollapseView.roundCorners(corners: [.topLeft,.topRight] , radius: 40.0)
            self.btnKm.setRound(withBorderColor: UIColor.clear, andCornerRadious: self.btnKm.frame.height/2.0, borderWidth: 1.0)
            
            // self.btnKmsetupFilledButton()
            self.ivService.setRound()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblAddressTitle?.text = "Home".localized()
        self.lblAddressTitle?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblAddress?.text = "Lorem Ipsum, Lisbon, portugal 12451.".localized()
        self.lblAddress?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnBook?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnBook?.setTitle("BTN_BOOK_HERE".localized(), for: .normal)
        self.btnCheckService?.setTitle("BTN_CHECK_SERVICE".localized(), for: .normal)
        self.btnCheckService?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.setupCollectionView()
    }
    
    // MARK: Action Buttons
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        _ = (self.navigationController as? NC)?.popVC()
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
    
    func openRecipientSelectionDialog() {
        
        let recipientSelectionDialog: RecipientSelectionDialog  = RecipientSelectionDialog.fromNib()
        recipientSelectionDialog.initialize(title: "RECIEPENT_DIALOG__TITLE".localized(), buttonTitle: "RECIEPENT_DIALOG_BTN_ADD".localized(), cancelButtonTitle: "BTN_BACK".localized())
        recipientSelectionDialog.show(animated: true)
        recipientSelectionDialog.onBtnCancelTapped = {
            [weak recipientSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            recipientSelectionDialog?.dismiss()
            
        }
        recipientSelectionDialog.onBtnDoneTapped = {
            [weak recipientSelectionDialog, weak self] (people) in
            guard let self = self else { return } ; print(self)
            recipientSelectionDialog?.dismiss()
            
            let bookingData: BookingInfo = BookingInfo.init()
            bookingData.reciepent = people
            bookingData.user_people_id = people.id
            bookingData.services = []
            let arrForData = [bookingData]
            self.openReciepentMassageDetailVCDialog(data: arrForData)
        }
    }
    
    
    func openReciepentMassageDetailVCDialog(data:[BookingInfo]) {
        recipentMassageManageDialog = RecipentMassageManageDialog.fromNib()
        recipentMassageManageDialog.initialize(title: "RECIEPENT_DETAIL_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        recipentMassageManageDialog.arrForData = data
        recipentMassageManageDialog.show(animated: true)
        recipentMassageManageDialog.onBtnCancelTapped = {
            [weak recipentMassageManageDialog, weak self] in
            guard let self = self else {return}; print(self)
            recipentMassageManageDialog?.dismiss()
        }
        recipentMassageManageDialog.onBtnNextSelectedTapped = {
            [ weak self] (data) in
            guard let self = self else { return } ; print(self)
            appSingleton.myBookingData.serviceCenterDetail = self.arrForServices[self.currentIndex]
            appSingleton.myBookingData.booking_info = data
            self.openDateTimeSelectionDialog()
        }
    }
    
    func openTextViewPicker() {
        textViewDialog = TextViewDialog.fromNib()
        textViewDialog.initialize(title: "booking notes", data:appSingleton.myBookingData.special_notes, buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        textViewDialog.show(animated: true)
        textViewDialog.onBtnCancelTapped = {
            [weak textViewDialog, weak self] in
            guard let self = self else {return}; print(self)
            textViewDialog?.dismiss()
        }
        textViewDialog.onBtnDoneTapped = {
            [ weak self] (description) in
            guard let self = self else { return } ; print(self)
            appSingleton.myBookingData.special_notes = description
            
            appSingleton.myBookingData.serviceCenterDetail = self.arrForServices[self.currentIndex]
            appSingleton.myBookingData.shop_id = self.arrForServices[self.currentIndex].id
            self.openLanguagePicker()
        }
    }
    
    func dismissAllDialog() {
        self.recipentMassageManageDialog?.dismiss()
        self.sessionSelectionDialog?.dismiss()
        self.dialogForAccessory?.dismiss()
        self.textViewDialog?.dismiss()
        self.dateTimeSelectionDialog?.dismiss()
        self.languagePicker?.dismiss()
    }
    
    func openAccessoryDialog() {
        dialogForAccessory = AccessorySelectionDialog.fromNib()
        dialogForAccessory.initialize(title: "ACCESSORY_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        dialogForAccessory.show(animated: true)
        dialogForAccessory.onBtnCancelTapped = { [weak self, weak dialogForAccessory]  in
            guard let self = self else { return } ; print(self)
            dialogForAccessory?.dismiss()
        }
        dialogForAccessory.onBtnDoneTapped = {[weak self] (data) in
            guard let self = self else { return } ; print(self)
            self.dismissAllDialog()
            Common.appDelegate.loadReviewAndBookVC()
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
        dateTimeSelectionDialog =  DateTimeDialog.fromNib()
        dateTimeSelectionDialog.initialize(title: "DATE_DIALOG_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        dateTimeSelectionDialog.show(animated: true)
        dateTimeSelectionDialog.onBtnCancelTapped = {
            [weak dateTimeSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            dateTimeSelectionDialog?.dismiss()
        }
        dateTimeSelectionDialog.onBtnDoneTapped = {
            [weak self]  (millis)in
            guard let self = self else { return } ; print(self)
            appSingleton.myBookingData.date = millis.toString()
            self.openTextViewPicker()
        }
    }
    
    func openLanguagePicker() {
        languagePicker = CustomLanguagePicker.fromNib()
        languagePicker.initialize(title: SettingMenu.PreferredLanguage.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        languagePicker.show(animated: true)
        languagePicker.onBtnCancelTapped = {
            [weak languagePicker, weak self] in
            languagePicker?.dismiss()
             guard let self = self else { return } ; print(self)
        }
        languagePicker.onBtnDoneTapped = {
            [weak languagePicker, weak self] (language) in
            guard let self = self else { return } ; print(self)
            self.openAccessoryDialog()
        }
    }
    
    func openSessionSelectionDialog() {
        sessionSelectionDialog  = SessionDialog.fromNib()
        sessionSelectionDialog.initialize(title: "SESSION_TYPE_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        sessionSelectionDialog.show(animated: true)
        sessionSelectionDialog.onBtnCancelTapped = {
            [weak sessionSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            sessionSelectionDialog?.dismiss()
        }
        sessionSelectionDialog.onBtnDoneTapped = {
            [ weak self] (session) in
            guard let self = self else { return } ; print(self)
            
            appSingleton.myBookingData.session_id = session.id
            if PreferenceHelper.shared.getUserId().isEmpty()  {
                self.dismissAllDialog()
                Common.appDelegate.loadWelcomeVC()
            } else {
                //self.openReciepentMassageDetailVCDialog()
                self.openRecipientSelectionDialog()
            }
            
        }
    }
    
}



extension ServiceMapVC {
    
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
    func wsGetMassagePreferenceList() {
        
        Loader.showLoading()
        AppWebApi.massagePreferencceList { (response) in
            appSingleton.massagePrefrenceDetail.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.massagePreferenceList {
                    appSingleton.massagePrefrenceDetail.append(data)
                }
                
            }
            Loader.hideLoading()
        }
    }
    
    func setData() {
        self.collectionView.reloadData()
        self.cltForCollapseView.reloadData {
        }
        self.setCenterDataFor(index: 0)
    }
    
    func setCenterDataFor(index:Int) {
        DispatchQueue.main.async {
            self.scrollToItem(index: index)
            self.mapView.focusMap(locations: [self.currentMarker!.position,self.arrForServicesMarker[index].position])
            self.mapView.drawPolyline(polyline: self.path, source: self.currentMarker!.position, destination: self.arrForServices[index].getCoordinatte())
        }
    }
}
