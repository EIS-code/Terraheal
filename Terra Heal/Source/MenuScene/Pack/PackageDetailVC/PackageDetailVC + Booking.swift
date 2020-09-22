//
//  PackageDetailVC + Booking.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 22/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

extension PackageDetailVC  {
    func openRecipientSelectionDialog() {
           let recipientSelectionDialog: RecipientSelectionDialog  = RecipientSelectionDialog.fromNib()
           recipientSelectionDialog.initialize(title: "RECIEPENT_DIALOG__TITLE".localized(), buttonTitle: "RECIEPENT_DIALOG_BTN_ADD".localized(), cancelButtonTitle: "BTN_BACK".localized())
           recipientSelectionDialog.show(animated: true)
           recipientSelectionDialog.onBtnCancelTapped = {
               [weak recipientSelectionDialog, weak self] in
               guard let self = self else { return } ; print(self)
               recipientSelectionDialog?.dismiss()
           }
           recipientSelectionDialog.onBtnDoneTapped = {
               [weak recipientSelectionDialog, weak self] (people) in
               guard let self = self else { return } ; print(self)
               recipientSelectionDialog?.dismiss()
               let bookingData: BookingInfo = BookingInfo.init()
               bookingData.reciepent = people
               bookingData.user_people_id = people.id
               bookingData.services = []
               let arrForData = [bookingData]
               self.openReciepentMassageDetailVCDialog(data: arrForData)
           }
       }
       
       
       func openReciepentMassageDetailVCDialog(data:[BookingInfo]) {
           recipentMassageManageDialog = RecipentMassageManageDialog.fromNib()
           recipentMassageManageDialog.initialize(title: "RECIEPENT_DETAIL_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
           recipentMassageManageDialog.arrForData = data
           recipentMassageManageDialog.show(animated: true)
           recipentMassageManageDialog.onBtnCancelTapped = {
               [weak recipentMassageManageDialog, weak self] in
               guard let self = self else {return}; print(self)
               recipentMassageManageDialog?.dismiss()
           }
           recipentMassageManageDialog.onBtnNextSelectedTapped = {
               [ weak self] (data) in
               guard let self = self else { return } ; print(self)
               appSingleton.myBookingData.booking_info = data
               self.openDateTimeSelectionDialog()
           }
       }
       
       func openTextViewPicker() {
           textViewDialog = TextViewDialog.fromNib()
           textViewDialog.initialize(title: "booking notes", data:appSingleton.myBookingData.special_notes, buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
           textViewDialog.show(animated: true)
           textViewDialog.onBtnCancelTapped = {
               [weak textViewDialog, weak self] in
               guard let self = self else {return}; print(self)
               textViewDialog?.dismiss()
           }
           textViewDialog.onBtnDoneTapped = {
               [ weak self] (description) in
               guard let self = self else { return } ; print(self)
               appSingleton.myBookingData.special_notes = description
             Common.appDelegate.loadReviewAndBookVC()
            }
       }
       
       func dismissAllDialog() {
           self.recipentMassageManageDialog?.dismiss()
           self.sessionSelectionDialog?.dismiss()
           self.dialogForAccessory?.dismiss()
           self.textViewDialog?.dismiss()
           self.dateTimeSelectionDialog?.dismiss()
           self.languagePicker?.dismiss()
       }
       
       func openServiceSelectionDialog() {
           let serviceSelectionDialog: CustomServiceSelectionDialog  = CustomServiceSelectionDialog.fromNib()
           serviceSelectionDialog.initialize(title:"ABCD", buttonTitle: "BTN_BOOK_HERE".localized())
           serviceSelectionDialog.show(animated: true)
           serviceSelectionDialog.onBtnCancelTapped = {
               [weak serviceSelectionDialog, weak self] in
               guard let self = self else { return } ; print(self)
               serviceSelectionDialog?.dismiss()
           }
           serviceSelectionDialog.onBtnDoneTapped = {
               [weak serviceSelectionDialog, weak self]  in
               guard let self = self else { return } ; print(self)
               serviceSelectionDialog?.dismiss()
               self.openSessionSelectionDialog()
           }
       }
       
       func openDateTimeSelectionDialog() {
           dateTimeSelectionDialog =  DateTimeDialog.fromNib()
           dateTimeSelectionDialog.initialize(title: "DATE_DIALOG_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
           dateTimeSelectionDialog.show(animated: true)
           dateTimeSelectionDialog.onBtnCancelTapped = {
               [weak dateTimeSelectionDialog, weak self] in
               guard let self = self else { return } ; print(self)
               dateTimeSelectionDialog?.dismiss()
           }
           dateTimeSelectionDialog.onBtnDoneTapped = {
               [weak self]  (millis)in
               guard let self = self else { return } ; print(self)
               appSingleton.myBookingData.date = millis.toString()
               
               self.openTextViewPicker()
           }
       }
       
      
    func openSessionSelectionDialog() {
           sessionSelectionDialog  = SessionDialog.fromNib()
           sessionSelectionDialog.initialize(title: "SESSION_TYPE_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
           sessionSelectionDialog.show(animated: true)
           sessionSelectionDialog.onBtnCancelTapped = {
               [weak sessionSelectionDialog, weak self] in
               guard let self = self else { return } ; print(self)
               sessionSelectionDialog?.dismiss()
           }
           sessionSelectionDialog.onBtnDoneTapped = {
               [ weak self] (session) in
               guard let self = self else { return } ; print(self)
               
               appSingleton.myBookingData.session_id = session.id
               if PreferenceHelper.shared.getUserId().isEmpty()  {
                   self.dismissAllDialog()
                   Common.appDelegate.loadWelcomeVC()
               } else {
                   self.openRecipientSelectionDialog()
               }
               
           }
       }
}
