//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

struct SendingPreferenceDetail {
    var email:String = ""
    var dateToSend: String = ""
}
class CustomSendingPreferenceDialog: ThemeBottomDialogView {

    @IBOutlet weak var txtData: ACFloatingTextfield!
    @IBOutlet weak var vwSwitch: JDSegmentedControl!
    var onBtnDoneTapped: ((_ data: SendingPreferenceDetail) -> Void)? = nil
    var date: Double = 0.0
    var selectedData: SendingPreferenceDetail = SendingPreferenceDetail.init()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    func initialize(title:String, placeholder:String = "", data:String, buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.txtData.placeholder = placeholder
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
        self.vwSwitch.allowChangeThumbWidth = false
               self.vwSwitch.itemTitles = ["send now".localized(),"send later".localized()]
               self.vwSwitch.changeBackgroundColor(UIColor.themeLightTextColor)
               self.vwSwitch.didSelectItemWith = { [weak self] (index,title) in
                   guard let self = self else {return}; print(self)
                   if index == 0 {
                    self.date = Date().millisecondsSince1970
                    self.selectedData.dateToSend = ""
                   } else {
                    self.openDatePicker()
                   }
               }
        self.txtData?.placeholder = "".localized()
        self.txtData?.delegate = self
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }


    func checkValidation() -> Bool {
        
        if !txtData.validate().0 {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtData.validate().1)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                
                _ = self?.txtData.becomeFirstResponder()
            }
            return false
        }
        if self.selectedData.dateToSend.isEmpty() {
            self.date = Date().millisecondsSince1970
            self.selectedData.dateToSend = String(self.date)
        }
        self.selectedData.email = txtData.text!
        
        return true
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
        }
    }
    func configTextField(data:InputTextFieldDetail) {
        self.txtData.configureTextField(data)
        
    }

    func openDatePicker() {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        
        
      
        datePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_DATE".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
         datePickerAlert.setDate(minDate: Date(), maxDate: Date().addingTimeInterval(Date.millisecondsOfDay(day: 3)))
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
            self.date = date
            self.selectedData.dateToSend = String(self.date)
            
            print(date)
            
        }
    }
    
    
}

extension CustomSendingPreferenceDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
