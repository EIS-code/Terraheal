//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class EditProfileVC: MainVC {
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var vwBg: UIView!
    var kTableHeaderHeight:CGFloat = 150.0
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnAddPicture: UIButton!

    @IBOutlet weak var collectionVwForProfile: UICollectionView!

    var selectedCountry:Country? = nil
    var selectedCity:City? = nil

    var arrForProfile: [EditProfileTextFieldDetail] = [
        EditProfileTextFieldDetail(vlaue: appSingleton.user.name, placeholder: "name", isMadatory: true, contentType:TextFieldContentType.Other ),
        EditProfileTextFieldDetail(vlaue: appSingleton.user.name, placeholder: "surname", isMadatory: true, contentType: TextFieldContentType.Other),
        EditProfileTextFieldDetail(vlaue: appSingleton.user.gender, placeholder: "gender", isMadatory: true, contentType: TextFieldContentType.Gender),
        EditProfileTextFieldDetail(vlaue: appSingleton.user.dob, placeholder: "Date Of Birth", isMadatory: true, contentType: TextFieldContentType.DOB),
        EditProfileTextFieldDetail(vlaue: appSingleton.user.telNumber, placeholder: "Mobile", isMadatory: true, contentType: TextFieldContentType.Phone),
        EditProfileTextFieldDetail(vlaue: appSingleton.user.telNumber, placeholder: "Emergency Contact", isMadatory: true, contentType: TextFieldContentType.EmergencyContact),
        EditProfileTextFieldDetail(vlaue: appSingleton.user.email, placeholder: "Email", isMadatory: true, contentType: TextFieldContentType.Email),
        EditProfileTextFieldDetail(vlaue: "--", placeholder: "city", isMadatory: true, contentType: TextFieldContentType.City),
        EditProfileTextFieldDetail(vlaue: "--", placeholder: "country", isMadatory: true, contentType: TextFieldContentType.Country),
        EditProfileTextFieldDetail(vlaue: "--", placeholder: "Nif", isMadatory: true, contentType: TextFieldContentType.Nif),
        EditProfileTextFieldDetail(vlaue: "--", placeholder: "Id/ Password", isMadatory: true, contentType: TextFieldContentType.Other)
    ]
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
        self.setupCollectionView(collectionView: collectionVwForProfile)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.headerView.layoutIfNeeded()
        self.kTableHeaderHeight = self.headerView.frame.height
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
        

        self.lblTitle?.text = "edit profile"//appSingleton.user.name
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.btnBack.setBackButton()

        
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddPictureTapped(_ sender: Any) {
        self.openPhotoPicker()
    }
    // MARK: - Other Methods

    func openPhotoPicker() {
        let photoPickerAlert: CustomPhotoPicker = CustomPhotoPicker.fromNib()
        photoPickerAlert.initialize(title:"Select Photo", buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        photoPickerAlert.show(animated: true)
        photoPickerAlert.onBtnCancelTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return }
        }
        photoPickerAlert.onBtnDoneTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return }
        }
        photoPickerAlert.onBtnCameraTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return }
        }
        photoPickerAlert.onBtnGallaryTapped = { [weak photoPickerAlert, weak self] in
            photoPickerAlert?.dismiss()
            guard let self = self else { return }
        }

    }

    func openCountryPicker(index:Int = 0) {
        let countryPickerAlert: CustomCountyPicker = CustomCountyPicker.fromNib()
        countryPickerAlert.initialize(title:arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        countryPickerAlert.show(animated: true)
        countryPickerAlert.onBtnCancelTapped = { [weak countryPickerAlert, weak self] in
            countryPickerAlert?.dismiss()
        }
        countryPickerAlert.onBtnDoneTapped = { [weak countryPickerAlert, weak self] (country) in
            countryPickerAlert?.dismiss()
            self?.selectedCountry = country
            self?.arrForProfile[7].vlaue = country.name
            self?.collectionVwForProfile.reloadData()
        }
    }

    func openCityPicker(index:Int = 0,countryId:String) {

        if countryId.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_SELECT_COUNTRY_FIRST".localized())
            return
        }
        let cityPickerAlert: CustomCityPicker = CustomCityPicker.fromNib()
        cityPickerAlert.getCityList(countryId: selectedCountry!.id)
        cityPickerAlert.initialize(title: arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        cityPickerAlert.show(animated: true)
        cityPickerAlert.onBtnCancelTapped = {
            [weak cityPickerAlert, weak self] in
            cityPickerAlert?.dismiss()
        }
        cityPickerAlert.onBtnDoneTapped = {
            [weak cityPickerAlert, weak self] (city) in
            cityPickerAlert?.dismiss()
            self?.selectedCity = city
            self?.arrForProfile[6].vlaue = city.name
            self?.collectionVwForProfile.reloadData()
        }
    }
    func openTextFieldPicker(index:Int = 0) {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: arrForProfile[index].placeholder, data: arrForProfile[index].vlaue, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        if arrForProfile[index].contentType == .Email {
            alert.txtData.keyboardType = .emailAddress
        } else if arrForProfile[index].contentType == .Nif {
            alert.txtData.keyboardType = .numberPad
        }
        else {
            alert.txtData.keyboardType = .default
        }



        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
            guard let self = self else { return }
            self.arrForProfile[index].vlaue = description
            self.collectionVwForProfile.reloadData()
        }
    }

    func openMobileNumberDialog(index:Int = 0) {
        let alert: CustomMobileNumberDialog = CustomMobileNumberDialog.fromNib()
        alert.initialize(title: arrForProfile[index].placeholder,countryPhoneCode: "+91",phoneNumber: "9876543210", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (countryPhoneCode,mobileNumber) in
            alert?.dismiss()
            guard let self = self else { return }
            self.arrForProfile[index].vlaue = countryPhoneCode + " " + mobileNumber
            self.collectionVwForProfile.reloadData()
        }
    }


    func openTextViewPicker(index:Int = 0) {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
         alert.initialize(title: arrForProfile[index].placeholder, data: arrForProfile[index].vlaue, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
            guard let self = self else { return }
            self.arrForProfile[index].vlaue = description
            self.collectionVwForProfile.reloadData()
        }
    }


    func openDatePicker(index:Int = 0) {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        datePickerAlert.initialize(title: arrForProfile[index].placeholder, buttonTitle: "Proceed",cancelButtonTitle: "Back")
        datePickerAlert.show(animated: true)
        datePickerAlert.onBtnCancelTapped = {
            [weak datePickerAlert, weak self] in
            datePickerAlert?.dismiss()
        }
        datePickerAlert.onBtnDoneTapped = {
            [weak datePickerAlert, weak self] (date) in
            datePickerAlert?.dismiss()
            print()
            self?.arrForProfile[index].vlaue = Date.milliSecToDate(milliseconds: date, format: "dd MMM yyyy")
            self?.collectionVwForProfile.reloadData()
        }
    }

    func openGenderPicker(index:Int = 0) {
        let genderPickerAlert: CustomGenderPicker = CustomGenderPicker.fromNib()
        genderPickerAlert.selectedGender = Gender.Female
        genderPickerAlert.initialize(title: arrForProfile[index].placeholder, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        genderPickerAlert.show(animated: true)
        genderPickerAlert.onBtnCancelTapped = {
            [weak genderPickerAlert, weak self] in
            genderPickerAlert?.dismiss()
        }
        genderPickerAlert.onBtnDoneTapped = {
            [weak genderPickerAlert, weak self] (gender) in
            genderPickerAlert?.dismiss()
            self?.arrForProfile[index].vlaue = gender.name()
            self?.collectionVwForProfile.reloadData()

        }
    }

}


extension EditProfileVC:  UIScrollViewDelegate {


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

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let data = arrForProfile[indexPath.row]
        switch data.contentType {
        case .Other :
            self.openTextFieldPicker(index: indexPath.row)
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
            return CGSize(width: (size / 2.0) - 10, height: size * 0.2)
        }
        return CGSize(width: size , height: size * 0.2)
    }


}
