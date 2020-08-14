//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class ServiceSelectionVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    var selectedServiceType: ServiceType = ServiceType.Massages
    var arrForData: [ServiceDetail] = []
    var arrForMassage: [ServiceDetail] = []
    var arrForTherapies: [ServiceDetail] = []
    var selectedService: ServiceDetail = ServiceDetail.init(fromDictionary: [:])
    var onBtnServiceSelectedTapped: ((_ data: BookingInfo) -> Void)? = nil
    var bookingDetail:BookingInfo? = nil
    // MARK: Object lifecycle
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            vwServiceSelection.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwServiceSelection.bounds.height/2.0, borderWidth: 0.1)
            vwServiceSelection.setShadow()
            self.collectionVw?.reloadData({
                
            })
            
        }
        
        
    }
    private func initialViewSetup() {
        self.setTitle(title: "SELECT_SERIVICE_TITLE".localized())
        self.setupCollectionView(collectionView: self.collectionVw)
        self.vwServiceSelection.allowChangeThumbWidth = false
        self.vwServiceSelection.itemTitles = ["massages".localized(),"therapies".localized()]
        self.vwServiceSelection.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwServiceSelection.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {
                return
            }
            
            if index == 0 {
                self.massagesTapped()
            } else {
                self.therapiesTapped()
            }
        }
        
        self.getServiceCenterDetail()
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true) {
                 _ = (self.navigationController as? NC)?.popVC()
        }
    }
    
    func massagesTapped(){
        self.arrForData = self.arrForMassage
        self.vwServiceSelection.selectItemAt(index: 0)
        self.selectedServiceType = ServiceType.Massages
        collectionVw.reloadData()
    }
    
    func therapiesTapped(){
        self.arrForData = self.arrForTherapies
        self.vwServiceSelection.selectItemAt(index: 1)
        self.selectedServiceType = ServiceType.Therapies
        collectionVw.reloadData()
    }
    
    func openServiceDurationSelection(index: Int) {
        self.selectedService = self.arrForData[index]
        let durationSelectionDialog: DurationSelectionDialog = DurationSelectionDialog.fromNib()
        durationSelectionDialog.initialize(title: "Select duration",message: "note:- 23% VAT is included", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        durationSelectionDialog.setDataSource(data: arrForData[index].duration)
        durationSelectionDialog.show(animated: true)
        durationSelectionDialog.onBtnCancelTapped = {
            [weak durationSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            durationSelectionDialog?.dismiss()
        }
        durationSelectionDialog.onBtnDoneTapped = {
            [weak durationSelectionDialog, weak self]  (hour) in
            guard let self = self else { return } ; print(self)
            durationSelectionDialog?.dismiss()
            for i in 0..<self.selectedService.duration.count {
                  self.selectedService.duration[i].isSelected = false
                if self.selectedService.duration[i].id == hour.id {
                   self.selectedService.duration[i].isSelected = true
                    self.selectedService.selectedDuration = hour
                }
            }
            self.bookingDetail?.services.append(self.selectedService)
            let massageInfo = MyMassageInfo.init()
            massageInfo.massage_prices_id = self.selectedService.selectedDuration.pricing.id
            self.bookingDetail?.massage_info.append(massageInfo)
            self.openPreferGenderPicker()
        }
    }
    func openPreferGenderPicker() {
           if let pressureData = appSingleton.getPreferedGender() {
               let alert: CustomPreferGenderPicker = CustomPreferGenderPicker.fromNib()
            alert.initialize(title: MassagePreferenceMenu.GenderPreference.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
               alert.setDataSource(data: pressureData.preferenceOptions)
               alert.show(animated: true)
               alert.onBtnCancelTapped = {
                   [weak alert, weak self] in
                   guard let self = self else {return}; print(self)
                   alert?.dismiss()
               }
               alert.onBtnDoneTapped = {
                   [weak alert, weak self] (preferenceData) in
                    guard let self = self else { return } ; print(self)
                    alert?.dismiss()
                self.bookingDetail?.massage_info.last?.preference = preferenceData.id
                    self.openPressurerPicker()
               }
           }
    }
    func openPressurerPicker() {
        if let pressureData = appSingleton.getPressureDetail() {
                let alert: CustomPressurePicker = CustomPressurePicker.fromNib()
            alert.initialize(title: MassagePreferenceMenu.Pressure.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
                alert.setDataSource(data: pressureData)
                alert.show(animated: true)
                alert.onBtnCancelTapped = {
                    [weak alert, weak self] in
                    guard let self = self else {return}; print(self)
                    alert?.dismiss()
                }
                alert.onBtnDoneTapped = {
                    [weak alert, weak self] (preferenceData) in
                     guard let self = self else { return } ; print(self)
                    alert?.dismiss()
                    self.bookingDetail?.massage_info.last?.massage_preference_option_id = preferenceData.id
                    self.openTextViewPicker()
                }

        }
    }
    func openTextViewPicker() {
        let alert: TextViewDialog = TextViewDialog.fromNib()
        alert.initialize(title: "booking notes", data: self.bookingDetail?.massage_info.last?.notes ?? "" , buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized(), isMandatory: false)
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
            self.bookingDetail?.massage_info.last?.notes = description
            if self.onBtnServiceSelectedTapped != nil {
                self.onBtnServiceSelectedTapped!(self.bookingDetail!)
            }
            
        }
    }
    
    
}


// MARK: - CollectionView Methods
extension ServiceSelectionVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
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
        self.openServiceDurationSelection(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }
    
    
}

extension ServiceSelectionVC {
    func getServiceCenterDetail() {
        AppWebApi.massageCenterDetail { (response) in
            if ResponseModel.isSuccess(response: response) {
                for data in response.serviceList {
                    self.arrForData.append(data)
                    self.arrForMassage.append(data)
                    self.arrForTherapies.append(data)
                    self.collectionVw.reloadData()
                }
            }
        }
    }
}
