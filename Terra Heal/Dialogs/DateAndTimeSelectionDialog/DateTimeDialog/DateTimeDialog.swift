//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class DateTimeDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var btnDone: FloatingRoundButton!
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnNext: ThemeButton!
    var onBtnDoneTapped : (() -> Void)? = nil
    
    @IBOutlet weak var vwForDateSelection: UIView!
    @IBOutlet weak var lblSelectDate: ThemeLabel!
    @IBOutlet weak var lblDateValue: ThemeLabel!
    @IBOutlet weak var btnSelectDate: ThemeButton!
    
    @IBOutlet weak var vwForTimeSelection: UIView!
    @IBOutlet weak var lblSelectTime: ThemeLabel!
    @IBOutlet weak var lblTimeValue: ThemeLabel!
    @IBOutlet weak var btnSelectTime: ThemeButton!
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.btnNext.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }
    
    func initialSetup() {
        self.backgroundColor = .clear
        dialogView.clipsToBounds = true
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.lblSelectDate.text = "DATE_DIALOG_LBL_SELECT_DATE".localized()
        self.lblSelectTime.text = "DATE_DIALOG_LBL_SELECT_TIME".localized()
        self.lblSelectDate.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblSelectTime.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblDateValue.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblTimeValue.setFont(name: FontName.Regular, size: FontSize.label_14)
        
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.addPanGesture(view: self)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.btnDone.setForwardButton()
        self.btnNext.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwForDateSelection?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
        self.vwForTimeSelection?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
    }
    
    @IBAction func onClickBtnDone(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
    
    @IBAction func btnCalcelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }
    
    @IBAction func btnDateTapped(_ sender: Any) {
        self.openDatePicker()
    }
    
    @IBAction func btnTimeTapped(_ sender: Any) {
          self.openTimePicker()
      }
    
    func openDatePicker() {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        datePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_DATE".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
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
            self.lblDateValue.text = Date.milliSecToDate(milliseconds: date, format: DateFormat.BookingDateSelection)
        }
    }
    
    func openTimePicker() {
        let timePickerAlert: TimeDialog = TimeDialog.fromNib()
        timePickerAlert.initialize(title: "DATE_DIALOG_LBL_SELECT_TIME".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        timePickerAlert.show(animated: true)
        timePickerAlert.onBtnCancelTapped = {
            [weak timePickerAlert, weak self] in
            guard let self = self else { return } ; print(self)
            timePickerAlert?.dismiss()
        }
        timePickerAlert.onBtnDoneTapped = {
            [weak timePickerAlert, weak self] (date) in
            guard let self = self else { return } ; print(self)
            timePickerAlert?.dismiss()
            self.lblTimeValue.text = Date.milliSecToDate(milliseconds: date, format: DateFormat.BookingTimeSelection)
        }
    }
    
    
}


