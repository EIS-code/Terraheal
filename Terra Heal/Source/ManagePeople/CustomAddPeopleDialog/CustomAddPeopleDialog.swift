//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomAddPeopleDialog: ThemeBottomDialogView {


    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
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
    var onBtnDoneTapped: ((_ people:PeopleDetail) -> Void)? = nil
    var onBtnDeleteTapped: (() -> Void)? = nil
    var selectedPeople:PeopleDetail = PeopleDetail.init()
    var selectedGender:Gender = Gender.Male



    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)



    func initialize(title:String, data:PeopleDetail?,  buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.btnDelete.isHidden = true
        if data != nil {
            self.btnDelete.isHidden = false
            self.selectedPeople = data!
            self.setData()
        }
        self.lblTitle.text = title
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        self.select(gender: self.selectedGender)
    }

    func setData() {
        self.txtAge.text = self.selectedPeople.age
        self.txtName.text = self.selectedPeople.name
        self.selectedGender = self.selectedPeople.gender
        self.select(gender: self.selectedGender)
    }

    func select(gender:Gender) {
        self.selectedGender = gender
        btnMale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.themePrimary : UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.5)
        ivMaleSelected.isHidden = (gender == Gender.Male) ? false : true
        ivFemaleSelected.isHidden = (gender == Gender.Male) ? true : false
        btnFemale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.clear : UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.5)
        btnFemale?.setShadow()
        btnMale?.setShadow()
        ivMaleSelected?.setRound()
        ivFemaleSelected?.setRound()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.txtName.placeholder = "MANAGE_PEOPLE_TXT_NAME".localized()
        self.txtAge.placeholder = "MANAGE_PEOPLE_TXT_AGE".localized()
        self.lblMale.text = "GENDER_MALE".localized()
        self.lblMale.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblFemale.text = "GENDER_FEMALE".localized()
        self.lblFemale.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnDone.setHighlighted(isHighlighted: true)
        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.addPanGesture(view: dialogView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgProfilePic?.layoutIfNeeded()
        self.btnFemale?.setShadow()
        self.btnMale?.setShadow()
        self.btnTherapistGender?.setHighlighted(isHighlighted: false)
        self.btnDone?.setHighlighted(isHighlighted: true)
        self.imgProfilePic?.setRound()
        self.btnAddPicture?.setRound()
        self.ivMaleSelected?.setRound()
        self.ivFemaleSelected?.setRound()
        self.vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
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
            selectedPeople.gender = self.selectedGender

            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedPeople);
            }
        }
    }

    @IBAction func btnTherapistTapped(_ sender: Any) {
        self.btnTherapistGender.isEnabled = false
        self.openPreferGenderPicker()
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
                alert?.dismiss()
                _ = self?.txtAge.becomeFirstResponder()
            }
            return false
        }

        return true
    }

    func openPreferGenderPicker() {
        let alert: CustomPreferGenderPicker = CustomPreferGenderPicker.fromNib()
        alert.initialize(title: MassagePreferenceMenu.GenderPreference.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.select(gender: appSingleton.myMassagePreference.prefereGender)
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return }
            alert?.dismiss()
            self.btnTherapistGender.isEnabled = true
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (gender) in
            guard let self = self else { return }

            alert?.dismiss()
            self.selectedPeople.preferGender = gender
            self.btnTherapistGender.isEnabled = true
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
