//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

struct RecipientDetail {
    var name: String = ""
    var lastname: String = ""
    var secondName: String = ""
    var email: String = ""
    var mobileNumber: String = ""
    var message: String = ""
}

class CustomRecipientDetailDialog: ThemeBottomDialogView {

    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtLastName: ACFloatingTextfield!
    @IBOutlet weak var txtSecondName: ACFloatingTextfield!
    @IBOutlet weak var txtMobile: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    
    var onBtnDoneTapped: ((_ data: RecipientDetail ) -> Void)? = nil
    var selectedData: RecipientDetail? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.txtName.text = ""
        self.txtMobile.text = ""
        self.txtEmail.text = ""
        self.txtLastName.text = ""
        self.txtSecondName.text = ""
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

    override func initialSetup() {
        super.initialSetup()
        self.txtName?.placeholder = "name".localized()
        self.txtName.delegate = self
        self.txtSecondName?.placeholder = "second name (optional)".localized()
        self.txtSecondName.delegate = self
        self.txtLastName?.placeholder = "last name".localized()
        self.txtLastName.delegate = self
        self.txtMobile?.placeholder = "mobile".localized()
        self.txtMobile.delegate = self
        self.txtMobile.configureTextField(InputTextFieldDetail.getMobileConfiguration())
        self.txtEmail?.placeholder = "email".localized()
        self.txtEmail.delegate = self
        self.txtEmail.configureTextField(InputTextFieldDetail.getEmailConfiguration())
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.setDataForStepUpAnimation()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
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
        }
          else  if txtLastName.text!.isEmpty {
                let alert: CustomAlert = CustomAlert.fromNib()
                alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
                alert.show(animated: true)
                alert.onBtnCancelTapped = {
                    [weak alert, weak self] in
                    alert?.dismiss()
                    _ = self?.txtLastName.becomeFirstResponder()
                }
                return false
            }
        else if txtEmail.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtEmail.becomeFirstResponder()
            }
            return false
        }
       else {
            return true
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            selectedData = RecipientDetail()
            selectedData?.name = txtName.text!
            selectedData?.lastname = txtLastName.text!
            selectedData?.secondName = txtSecondName.text!
            selectedData?.email = txtEmail.text!
            selectedData?.mobileNumber = txtMobile.text!
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData!);
            }
        }
    }

}

extension CustomRecipientDetailDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
extension CustomRecipientDetailDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("abcd")
    }
}
