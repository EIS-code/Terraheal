//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomMobileNumberDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var txtCountryPhoneCode: ACFloatingTextfield!

    var onBtnDoneTapped: ((_ countryPhoneCode: String,_ phoneNumber: String) -> Void)? = nil

    func initialize(title:String, countryPhoneCode:String = "", phoneNumber:String = "", buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.txtCountryPhoneCode.text = countryPhoneCode
        self.txtMobileNumber.text = phoneNumber
        self.btnDone.setTitle(buttonTitle, for: .normal)

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

    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.txtMobileNumber?.placeholder = "".localized()
        self.txtMobileNumber?.delegate = self
        self.txtCountryPhoneCode?.placeholder = "".localized()
        self.txtCountryPhoneCode?.delegate = self

        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.addPanGesture(view: self)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)
        self.btnDone.setHighlighted(isHighlighted: true)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.setHighlighted(isHighlighted: true)
    }


    func checkValidation() -> Bool {
        if txtCountryPhoneCode.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtCountryPhoneCode.becomeFirstResponder()
            }
            return false
        }
        else if txtMobileNumber.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtMobileNumber.becomeFirstResponder()
            }
            return false
        }
        return true
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(txtCountryPhoneCode.text!, txtMobileNumber!.text!);
            }
        }
    }

    func openCountryCodePicker() {
        let alert: CustomCountyPhoneCodePicker = CustomCountyPhoneCodePicker.fromNib()
        alert.initialize(title: "Country Phone Code",buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (countryPhoneCode:  CountryPhone) in
            alert?.dismiss()
            guard let self = self else { return }
            self.txtCountryPhoneCode.text = countryPhoneCode.countryPhoneCode
            print(countryPhoneCode.countryName)

        }
    }
}

extension CustomMobileNumberDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCountryPhoneCode {
            self.openCountryCodePicker()
            return false
        }
        return true
    }
}
