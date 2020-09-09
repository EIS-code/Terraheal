//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class EditProfileVC: MainVC {
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var vwBg: UIView!
    var kTableHeaderHeight:CGFloat = 150.0
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnAddPicture: UIButton!
    @IBOutlet weak var collectionVwForProfile: UICollectionView!
    var selectedCountry:Country? = nil
    var selectedCity:City? = nil
    var arrForProfile: [EditProfileTextFieldDetail] = []
    var selectedProfileDoc: UploadDocumentDetail? = nil
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
        self.setUserData()
        self.setupCollectionView(collectionView: collectionVwForProfile)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        scrVw.addGestureRecognizer(singleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerView.layoutIfNeeded()
        self.kTableHeaderHeight = self.headerView.bounds.height
        print(self.kTableHeaderHeight)
        scrVw.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isViewAvailable() {
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow()
            self.ivProfilePic?.setRound()
            self.btnAddPicture?.setRound()
            //self.collectionVwForProfile?.reloadData()
        }
    }
    
    private func initialViewSetup() {
        self.view.backgroundColor = UIColor.themeBackground
        self.setTitle(title: "edit profile")
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnAddPictureTapped(_ sender: Any) {
        self.openPhotoPicker()
    }
    // MARK: - Other Methods
    
    func openPhotoPicker() {
        
        let photoPickerAlert: CustomPhotoPicker = CustomPhotoPicker.fromNib()
        photoPickerAlert.initialize(title:"PHOTO_DIALOG_FROM_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        photoPickerAlert.onBtnCameraTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.selectedProfileDoc = doc
            self.openCropper(image: doc.image ?? UIImage())
            
        }
        photoPickerAlert.onBtnGallaryTapped = { [weak photoPickerAlert, weak self] (doc) in
            photoPickerAlert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.selectedProfileDoc = doc
            self.openCropper(image: doc.image ?? UIImage())
            //let gallaryVC:GallaryVC = Common.appDelegate.loadGallaryVC(navigaionVC: self.navigationController)
        }
    }
    
    func openCropper(image: UIImage) {
        
        let cropper: UIImageCropperVC = UIImageCropperVC.fromNib()
        cropper.cropRatio = 1/1
        cropper.delegate = self
        cropper.picker = nil
        cropper.image = image
        cropper.cancelButtonText = "Cancel"
        cropper.view.layoutIfNeeded()
        self.navigationController?.pushViewController(cropper, animated: true)
    }
    
    func openCountryPicker(index:Int = 0) {
        let countryPickerAlert: CustomCountryPicker = CustomCountryPicker.fromNib()
        countryPickerAlert.initialize(title:arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        countryPickerAlert.show(animated: true)
        countryPickerAlert.onBtnCancelTapped = { [weak countryPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            countryPickerAlert?.dismiss()
        }
        countryPickerAlert.onBtnDoneTapped = { [weak countryPickerAlert, weak self] (country) in
            guard let self = self else { return } ; print(self)
            countryPickerAlert?.dismiss()
            self.selectedCountry = country
            var request: User.RequestProfile = User.RequestProfile()
            request.country_id = country.id
            self.wsUpdateProfile(request: request)
        }
    }
    
    func openCityPicker(index:Int = 0,countryId:String) {
        
        if countryId.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_SELECT_COUNTRY_FIRST".localized())
            return
        }
        let cityPickerAlert: CustomCityPicker = CustomCityPicker.fromNib()
        cityPickerAlert.initialize(title: arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized(), countryId: selectedCountry!.id)
        cityPickerAlert.show(animated: true)
        cityPickerAlert.onBtnCancelTapped = {
            [weak cityPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            cityPickerAlert?.dismiss()
        }
        cityPickerAlert.onBtnDoneTapped = {
            [weak cityPickerAlert, weak self] (city) in
            guard let self = self else { return } ; print(self)
            cityPickerAlert?.dismiss()
            self.selectedCity = city
            var request: User.RequestProfile = User.RequestProfile()
            request.city_id = city.id
            self.wsUpdateProfile(request: request)
        }
    }
    func openTextFieldPicker(index:Int = 0) {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: arrForProfile[index].placeholder, data: arrForProfile[index].value, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized(), isMandatory: false)
        alert.show(animated: true)
        let data =  self.arrForProfile[index]
        alert.configTextField(data: data.inputConfiguration)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.arrForProfile[index].value = description
            var request: User.RequestProfile = User.RequestProfile()
            switch self.arrForProfile[index].contentType
            {
            case .Name:
                request.name = description
            case .Surname:
                request.surname = description
            case .IdPassport:
                request.id_passport = description
            case .Nif :
                request.nif = description
            case .Email :
                request.email = description
            default : print("Default")
            }
            self.wsUpdateProfile(request: request)
        }
    }
    
    func openMobileNumberDialog(index:Int = 0) {
        let alert: CustomMobileNumberDialog = CustomMobileNumberDialog.fromNib()
        switch self.arrForProfile[index].contentType {
        case .EmergencyContact:
            alert.initialize(title: arrForProfile[index].placeholder,countryPhoneCode: appSingleton.user.emergencyTelNumberCode,phoneNumber: appSingleton.user.emergencyTelNumber, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        case .Phone:
            alert.initialize(title: arrForProfile[index].placeholder,countryPhoneCode: appSingleton.user.telNumberCode,phoneNumber: appSingleton.user.telNumber, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        default : print("Default")
        }
        
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (countryPhoneCode,mobileNumber) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            var request: User.RequestProfile = User.RequestProfile()
            switch self.arrForProfile[index].contentType
            {
            case .EmergencyContact:
                request.emergency_tel_number = mobileNumber
                request.emergency_tel_number_code = countryPhoneCode
            case .Phone:
                request.tel_number = mobileNumber
                request.tel_number_code = countryPhoneCode
            default : print("Default")
            }
            self.wsUpdateProfile(request: request)
            
        }
    }
    
    func openDatePicker(index:Int = 0) {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        datePickerAlert.initialize(title: arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        
        let minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date()) ?? Date()
        
        datePickerAlert.setDate(minDate: minimumDate , maxDate: Date())
        datePickerAlert.show(animated: true)
        datePickerAlert.onBtnCancelTapped = {
            [weak datePickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            datePickerAlert?.dismiss()
        }
        datePickerAlert.onBtnDoneTapped = {
            [weak datePickerAlert, weak self] (date) in
            guard let self = self else { return } ; print(self)
            datePickerAlert?.dismiss()
            var request: User.RequestProfile = User.RequestProfile()
            request.dob = date.toString()
            self.wsUpdateProfile(request: request)
        }
    }
    
    func openGenderPicker(index:Int = 0) {
        let genderPickerAlert: CustomGenderPicker = CustomGenderPicker.fromNib()
        genderPickerAlert.selectedGender = Gender.Female
        genderPickerAlert.initialize(title: arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        genderPickerAlert.show(animated: true)
        genderPickerAlert.onBtnCancelTapped = {
            [weak genderPickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            genderPickerAlert?.dismiss()
        }
        genderPickerAlert.onBtnDoneTapped = {
            [weak genderPickerAlert, weak self] (gender) in
            guard let self = self else { return } ; print(self)
            genderPickerAlert?.dismiss()
            var request: User.RequestProfile = User.RequestProfile()
            request.gender = gender.rawValue
            self.wsUpdateProfile(request: request)
            
        }
    }
    
    func setUserData() {
        
        self.ivProfilePic.downloadedFrom(link: appSingleton.user.profilePhoto)
        self.arrForProfile = [
            EditProfileTextFieldDetail(placeholder: "PROFILE_NAME".localized(), value: appSingleton.user.name,  contentType:TextFieldContentType.Name, inputConfiguration: InputTextFieldDetail.getNameConfiguration(), image: ImageAsset.EditProfile.name),
            EditProfileTextFieldDetail(placeholder: "PROFILE_SURNAME".localized(), value: ""/*appSingleton.user.surname*/, contentType:TextFieldContentType.Surname, inputConfiguration: InputTextFieldDetail.getNameConfiguration(), image: ImageAsset.EditProfile.name),
            EditProfileTextFieldDetail(placeholder: "PROFILE_GENDER".localized(), value: appSingleton.user.getGenderName(), contentType: TextFieldContentType.Gender, image: ImageAsset.EditProfile.gender),
            EditProfileTextFieldDetail(placeholder: "PROFILE_DOB".localized(), value: appSingleton.user.getDob(), contentType: TextFieldContentType.DOB, image: ImageAsset.EditProfile.dob),
            EditProfileTextFieldDetail(placeholder: "PROFILE_MOBILE".localized(), value: appSingleton.user.telNumberCode + " " + appSingleton.user.telNumber, contentType: TextFieldContentType.Phone, inputConfiguration: InputTextFieldDetail.getMobileConfiguration(), image: ImageAsset.EditProfile.mobile),
            
            EditProfileTextFieldDetail(placeholder: "PROFILE_EMERGENCY_CONTACT".localized(), value: appSingleton.user.emergencyTelNumberCode + " " + appSingleton.user.emergencyTelNumber,  contentType: TextFieldContentType.EmergencyContact, inputConfiguration: InputTextFieldDetail.getMobileConfiguration(), image: ImageAsset.EditProfile.emergencyContact),
            
            EditProfileTextFieldDetail(placeholder: "PROFILE_EMAIL".localized(), value: appSingleton.user.email, contentType: TextFieldContentType.Email,inputConfiguration: InputTextFieldDetail.getEmailConfiguration(), image: ImageAsset.EditProfile.email),
            EditProfileTextFieldDetail(placeholder: "PROFILE_CITY".localized(), value: appSingleton.user.city.name,  contentType: TextFieldContentType.City, inputConfiguration: InputTextFieldDetail.getNameConfiguration(), image: ImageAsset.EditProfile.city),
            EditProfileTextFieldDetail(placeholder: "PROFILE_COUNTRY".localized(), value: appSingleton.user.country.name,  contentType: TextFieldContentType.Country, inputConfiguration: InputTextFieldDetail.getNameConfiguration(), image: ImageAsset.EditProfile.country),
            EditProfileTextFieldDetail(placeholder: "PROFILE_NIF".localized(), value: appSingleton.user.nif,  contentType: TextFieldContentType.Nif, inputConfiguration: InputTextFieldDetail.getNumberConfiguration(), image: ImageAsset.EditProfile.country),
            EditProfileTextFieldDetail(placeholder: "PROFILE_ID_PASSWORD".localized(), value: appSingleton.user.idPassport,  contentType: TextFieldContentType.IdPassport, inputConfiguration: InputTextFieldDetail.getNumberConfiguration(), image: ImageAsset.EditProfile.idPassport)
        ]
        self.selectedCity = appSingleton.user.city
        self.selectedCountry = appSingleton.user.country
        self.collectionVwForProfile.reloadData()
        
    }
}


extension EditProfileVC:  UIScrollViewDelegate {
    
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        var point = recognizer.location(in: self.scrVw)
        point.y = point.y + self.kTableHeaderHeight + self.scrVw.frame.origin.y
        let buttonFrame = self.btnAddPicture.superview!.convert(self.btnAddPicture.frame, to: self.view)
        if (buttonFrame.contains(point)) {
            self.btnAddPictureTapped(btnAddPicture ?? UIButton())
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    func updateHeaderView() {
        
        if self.scrVw.contentOffset.y < 0 {
            let y = abs(self.scrVw.contentOffset.y)
            let transLation = y/kTableHeaderHeight
            headerView.alpha = transLation
            headerView.transform = CGAffineTransform.init(scaleX: transLation, y: transLation)
            self.collectionVwForProfile.isScrollEnabled = false
        } else {
            headerView.alpha = 0.0
            self.collectionVwForProfile.isScrollEnabled = true
        }
    }
    
    
}


// MARK: - CollectionView Methods
extension EditProfileVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(EditProfileCell.nib()
            , forCellWithReuseIdentifier: EditProfileCell.name)
        scrVw.delegate = self
        
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForProfile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditProfileCell.name, for: indexPath) as! EditProfileCell
        cell.setData(data: self.arrForProfile[indexPath.row])
        cell.parent = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let data = arrForProfile[indexPath.row]
        switch data.contentType {
        case .Name,.Surname,.Nif, .Email :
            self.openTextFieldPicker(index: indexPath.row)
        case .IdPassport:
            Common.appDelegate.loadManageDocumentVC(navigaionVC: self.navigationController)
        case .Gender:
            self.openGenderPicker(index: indexPath.row)
        case .DOB:
            self.openDatePicker(index: indexPath.row)
        case .Phone:
            self.openMobileNumberDialog(index: indexPath.row)
        case .EmergencyContact:
            self.openMobileNumberDialog(index: indexPath.row)
        case .City:
            self.openCityPicker(index: indexPath.row, countryId: (selectedCountry?.id) ??  "")
        case .Country:
            self.openCountryPicker(index: indexPath.row)
        default:
            print("")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        let data = arrForProfile[indexPath.row]
        if data.contentType == .Country || data.contentType == .City  {
            return CGSize(width: (size / 2.0) - 10, height: size * 0.1)
        }
        return CGSize(width: size , height: size * 0.1)
    }
    
    
}

extension EditProfileVC {
    func wsUpdateProfile(request: User.RequestProfile) {
        Loader.showLoading()
        AppWebApi.profile(params: request) { (response) in
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                self.setUserData()
                
            }
        }
    }
    
    func wsUpdateProfile() {
        
        Loader.showLoading()
        if let data  = selectedProfileDoc?.image?.pngData() {
            selectedProfileDoc?.data = data
            let imgSizeInMB = data.count/1024/1024
            print("Image Size \(imgSizeInMB) MB")
        }
        AppWebApi.profile(params: User.RequestProfile(), image: selectedProfileDoc) { (response) in
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                //self.setUserData()
            }
        }
    }
}
extension EditProfileVC: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {
        ivProfilePic.image = croppedImage
        _ = (self.navigationController as? NC)?.popVC()
        self.ivProfilePic.image = croppedImage
        self.selectedProfileDoc?.image = croppedImage
        self.wsUpdateProfile()
    }
    
    //optional
    func didCancel() {
        print("did cancel")
        _ = (self.navigationController as? NC)?.popVC()
        //self.wsUpdateProfile()
    }
}
