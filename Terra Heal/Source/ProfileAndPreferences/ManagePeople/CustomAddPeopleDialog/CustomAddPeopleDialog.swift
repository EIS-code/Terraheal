//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomAddPeopleDialog: ThemeBottomDialogView {


    @IBOutlet weak var vwMainGender: UIView!
    @IBOutlet weak var vwMale: UIView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var lblMale: ThemeLabel!
    @IBOutlet weak var ivMaleSelected: UIImageView!
    @IBOutlet weak var vwFemale: UIView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var lblFemale: ThemeLabel!
    @IBOutlet weak var ivFemaleSelected: UIImageView!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var btnAddPicture: UIButton!
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtAge: ACFloatingTextfield!
    @IBOutlet weak var btnTherapistGender: ThemeButton!
    @IBOutlet weak var btnDelete: FloatingRoundButton!
    
    var onBtnDoneTapped: ((_ people:People,_ doc:UploadDocumentDetail?) -> Void)? = nil
    var onBtnDeleteTapped: (() -> Void)? = nil
    var selectedPeople:People = People.init(fromDictionary: [:])
    var selectedGender:Gender = Gender.Male
    var selectedProfileDoc: UploadDocumentDetail? = nil
    var genderPreferenceArray:[PreferenceOption] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:People?, genderPreference:[PreferenceOption],  buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.btnDelete.isHidden = true
        self.genderPreferenceArray = genderPreference
        if data != nil {
            self.btnDelete.isHidden = false
            self.selectedPeople = data!
            self.setData()
        }
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        self.select(gender: self.selectedGender)
        self.setDataForStepUpAnimation()
        self.setDialogHeight(height: self.arrForSteps.last ?? 0.75)
    }

    func setData() {
        self.txtAge.text = self.selectedPeople.age
        self.txtName.text = self.selectedPeople.name
        self.selectedGender = Gender.init(rawValue:self.selectedPeople.gender ) ?? Gender.Male
        self.select(gender: self.selectedGender)
        self.imgProfilePic.downloadedFrom(link: self.selectedPeople.photo)
        var selectedPrefereceGender: PreferenceOption = PreferenceOption.init(fromDictionary: [:])
        for data in genderPreferenceArray {
            data.isSelected = false
            if data.id ==  self.selectedPeople.userGenderPreferenceId {
                data.isSelected = true
                selectedPrefereceGender = data
            }
        }
        self.btnTherapistGender.setTitle(selectedPrefereceGender.name, for: .normal)
       
    }

    func select(gender:Gender) {
        self.selectedGender = gender
        btnMale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.themePrimary : UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.5)
        ivMaleSelected.isHidden = (gender == Gender.Male) ? false : true
        ivFemaleSelected.isHidden = (gender == Gender.Male) ? true : false
        btnFemale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.clear : UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.5)
    }

    override func initialSetup() {
        super.initialSetup()
        self.txtName.placeholder = "MANAGE_PEOPLE_TXT_NAME".localized()
        self.txtAge.placeholder = "MANAGE_PEOPLE_TXT_AGE".localized()
        self.lblMale.text = "GENDER_MALE".localized()
        self.lblMale.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblFemale.text = "GENDER_FEMALE".localized()
        self.lblFemale.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.dialogView?.layoutIfNeeded()
        self.imgProfilePic?.layoutIfNeeded()
        self.btnTherapistGender?.setRound(withBorderColor: UIColor.themeDarkText, andCornerRadious: (self.btnTherapistGender?.frame.height ?? 1.0)/2.0 , borderWidth: 1.0)
        self.imgProfilePic?.setRound()
        self.btnAddPicture?.setRound()
    
    }

    @IBAction func btnMaleTapped(_ sender: Any) {
        self.select(gender: Gender.Male)
    }
    @IBAction func btnFemaleTapped(_ sender: Any) {
        self.select(gender: Gender.Female)
    }

    @IBAction func btnDeleteTapped(_ sender: Any) {
        if self.onBtnDeleteTapped != nil {
            self.onBtnDeleteTapped!();
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if checkValidation() {
            selectedPeople.name = self.txtName.text ?? ""
            selectedPeople.age = self.txtAge.text ?? ""
            selectedPeople.gender = self.selectedGender.rawValue

            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedPeople,selectedProfileDoc);
            }
        }
    }

    @IBAction func btnTherapistTapped(_ sender: Any) {
        self.btnTherapistGender.isEnabled = false
        self.openPreferGenderPicker()
    }
    
    @IBAction func btnAddPictureTapped(_ sender: Any) {
        self.openPhotoPicker()
    }
    
    
    func checkValidation() -> Bool {
        if txtName.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtName.becomeFirstResponder()
            }
            return false
        } else  if txtAge.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else {return} ; print(self)
                alert?.dismiss()
                _ = self.txtAge.becomeFirstResponder()
            }
            return false
        }
        else  if selectedPeople.userGenderPreferenceId.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "select Therapist Gender".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else {return} ; print(self)
                alert?.dismiss()
                
            }
            return false
        }
        return true
    }

    func openPreferGenderPicker() {
        let alert: CustomPreferGenderPicker = CustomPreferGenderPicker.fromNib()
        alert.initialize(title: MassagePreferenceMenu.GenderPreference.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.setDataSource(data: self.genderPreferenceArray)
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.btnTherapistGender.isEnabled = true
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (gender) in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.selectedPeople.userGenderPreferenceId = gender.id
            self.btnTherapistGender.setTitle(gender.name, for: .normal)
            self.btnTherapistGender.isEnabled = true
        }
    }
    
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
        cropper.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            
            Common.appDelegate.getTopViewController()?.present(cropper, animated: true, completion: nil)
        }
    }

}

extension CustomAddPeopleDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName {
            _ = txtName.resignFirstResponder()
            _ = txtAge.becomeFirstResponder()
        } else {
            _ = textField.becomeFirstResponder()
        }
        return true
    }
}


extension CustomAddPeopleDialog: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?) {
        imgProfilePic.image = croppedImage
        self.selectedProfileDoc?.image = croppedImage
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
       // self.wsUpdateProfile()
        
    }
    
    //optional
    func didCancel() {
        print("did cancel")
        _ = (Common.appDelegate.getTopViewController() as? NC)?.popVC()
        //self.wsUpdateProfile()
    }
}

