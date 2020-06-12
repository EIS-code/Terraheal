//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomChangePasswordDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var txtOldPassword: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtConfirmPassword: ACFloatingTextfield!

    var onBtnDoneTapped: ((_ oldPassword: String,_ newPassword: String) -> Void)? = nil



    func initialize(title:String, buttonTitle:String,cancelButtonTitle:String) {
        self.lblTitle.text = title
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
        self.initialSetup()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear

        self.txtOldPassword?.placeholder = "CHANGE_PASSWORD_TXT_OLD_PASSWORD".localized()
        self.txtOldPassword?.delegate = self

        self.txtPassword?.placeholder = "CHANGE_PASSWORD_TXT_NEW_PASSWORD".localized()
        self.txtPassword?.delegate = self

        self.txtConfirmPassword?.placeholder = "CHANGE_PASSWORD_TXT_CONFIRM_PASSWORD".localized()
        self.txtConfirmPassword?.delegate = self

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
        if txtOldPassword.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_PASSWORD".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtPassword.becomeFirstResponder()
            }
            return false
        }
        else if txtPassword.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_PASSWORD".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtPassword.becomeFirstResponder()
            }
            return false
        } else if txtPassword.text! != txtConfirmPassword.text! {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_MISMATCH_CONFIRM_PASSWORD".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtConfirmPassword.becomeFirstResponder()

            }
            return false
        }
         return true
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(txtOldPassword!.text!,txtConfirmPassword!.text!);
            }
        }
    }

}

extension CustomChangePasswordDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtOldPassword {
            _ = txtPassword?.becomeFirstResponder()
        } else if textField == txtPassword {
            _ = txtConfirmPassword?.becomeFirstResponder()
        } else {
            _ = txtConfirmPassword?.resignFirstResponder()
        }
        return true
    }
}
