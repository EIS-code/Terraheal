//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

struct EventBookingDetail {
    var name: String = ""
    var email: String = ""
    var mobileNumber: String = ""
    var message: String = ""
}

class CustomAddNewEventDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtMobile: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtDescription: ThemeTextView!
    
    var onBtnDoneTapped: ((_ data: EventBookingDetail ) -> Void)? = nil
    var selectedData: EventBookingDetail? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.txtName.text = ""
        self.txtMobile.text = ""
        self.txtEmail.text = ""
        self.txtDescription.text = ""
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
        self.txtMobile?.placeholder = "mobile".localized()
        self.txtMobile.delegate = self
        self.txtEmail?.placeholder = "email".localized()
        self.txtEmail.delegate = self
        self.txtDescription?.placeholder = "message".localized()
        self.txtDescription.delegate = self
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
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
       
        else if txtName.text!.isEmpty {
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
        else {
            return true
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            selectedData = EventBookingDetail()
            selectedData?.name = txtName.text!
            selectedData?.message = txtDescription.text!
            selectedData?.email = txtEmail.text!
            selectedData?.mobileNumber = txtMobile.text!
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData!);
            }
        }
    }

}

extension CustomAddNewEventDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
extension CustomAddNewEventDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("abcd")
    }
}
