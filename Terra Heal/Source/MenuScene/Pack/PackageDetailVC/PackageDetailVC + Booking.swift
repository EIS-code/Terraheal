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
            let bookingData: PackageBookingInfo = PackageBookingInfo.init()
            bookingData.reciepent = people
            bookingData.user_people_id = people.id
            bookingData.services = appSingleton.requestUsePurchasePackage!.selectedServices
            let arrForData = [bookingData]
            self.openReciepentMassageDetailVCDialog(data: arrForData)
        }
    }
    
    
    func openReciepentMassageDetailVCDialog(data:[PackageBookingInfo]) {
        recipentMassageManageDialog = PackageDetailDialog.fromNib()
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
            appSingleton.requestUsePurchasePackage!.booking_info = data
            self.openPressurerPicker()
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
            appSingleton.requestUsePurchasePackage?.special_notes = description
            
            if appSingleton.requestUsePurchasePackage!.booking_type == BookingType.MassageCenter {
                Common.appDelegate.loadReviewAndBookVC()
            } else {
                self.openLanguagePicker()
            }
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
        sessionSelectionDialog.bookindType = appSingleton.requestUsePurchasePackage?.booking_type ?? BookingType.MassageCenter
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
            appSingleton.requestUsePurchasePackage?.session_id = session.id
            if PreferenceHelper.shared.getUserId().isEmpty()  {
                self.dismissAllDialog()
                Common.appDelegate.loadWelcomeVC()
            } else {
                self.openRecipientSelectionDialog()
            }
        }
    }
    
    func openBookingTypeSelectionDialog() {
        let serviceSelectionDialog: BookingTypeSelectionDialog  = BookingTypeSelectionDialog.fromNib()
        serviceSelectionDialog.initialize(title:"ABCD", buttonTitle: "BTN_BOOK_HERE".localized(), cancelButtonTitle: "BTN_BACK".localized())
        serviceSelectionDialog.show(animated: true)
        serviceSelectionDialog.onBtnCancelTapped = {
            [weak serviceSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            serviceSelectionDialog?.dismiss()
        }
        serviceSelectionDialog.onBtnDoneTapped = {
            [weak serviceSelectionDialog, weak self]  (data) in
            guard let self = self else { return } ; print(self)
            
            appSingleton.requestUsePurchasePackage?.booking_type = data
            serviceSelectionDialog?.dismiss()
            self.openSessionSelectionDialog()
        }
    }
    
    func openAccessoryDialog() {
            dialogForAccessory = AccessorySelectionDialog.fromNib()
            dialogForAccessory.initialize(title: "ACCESSORY_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
            dialogForAccessory.show(animated: true)
            dialogForAccessory.onBtnCancelTapped = { [weak self, weak dialogForAccessory]  in
                guard let self = self else { return } ; print(self)
                dialogForAccessory?.dismiss()
                appSingleton.requestUsePurchasePackage!.bring_table_futon = AccessoryType.None.rawValue
                appSingleton.requestUsePurchasePackage!.table_futon_quantity = "0"
                Common.appDelegate.loadReviewAndBookVC()
            }
            dialogForAccessory.onBtnDoneTapped = { [weak self] (quatity,accessoryType) in
                guard let self = self else { return } ; print(self)
                self.dismissAllDialog()
                if quatity != 0 {
                    appSingleton.requestUsePurchasePackage!.bring_table_futon = accessoryType.rawValue
                    appSingleton.requestUsePurchasePackage!.table_futon_quantity = quatity.toString()
                }
                Common.appDelegate.loadReviewAndBookVC()
            }
        }
    func openLanguagePicker() {
            languagePicker = CustomLanguagePicker.fromNib()
            languagePicker.initialize(title: SettingMenu.PreferredLanguage.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
            languagePicker.show(animated: true)
            languagePicker.onBtnCancelTapped = {
                [weak languagePicker, weak self] in
                languagePicker?.dismiss()
                 guard let self = self else { return } ; print(self)
            }
            languagePicker.onBtnDoneTapped = {
                [weak self] (language) in
                guard let self = self else { return } ; print(self)
                self.openAccessoryDialog()
            }
        }
    
    func openPressurerPicker() {
        if let pressureData = appSingleton.getPressureDetail() {
            pressureSelectionDialog = CustomPressurePicker.fromNib()
            pressureSelectionDialog.initialize(title: MassagePreferenceMenu.Pressure.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
                pressureSelectionDialog.setDataSource(data: pressureData)
                pressureSelectionDialog.show(animated: true)
                pressureSelectionDialog.onBtnCancelTapped = {
                    [weak pressureSelectionDialog, weak self] in
                    guard let self = self else {return}; print(self)
                    pressureSelectionDialog?.dismiss()
                }
                pressureSelectionDialog.onBtnDoneTapped = {
                    [ weak self] (preferenceData) in
                     guard let self = self else { return } ; print(self)
                    self.openFocusPressurerPicker()
                }
        }
    }
    
    func openFocusPressurerPicker() {
        
        if let pressureData = appSingleton.getFocusArea() {
                pressureFocusSelectionDialog = CustomFocusAreaPicker.fromNib()
                pressureFocusSelectionDialog.initialize(title: pressureData.name, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
                pressureFocusSelectionDialog.setDataSource(data: pressureData)
                pressureFocusSelectionDialog.show(animated: true)
                pressureFocusSelectionDialog.onBtnCancelTapped = {
                        [weak pressureFocusSelectionDialog, weak self] in
                        guard let self = self else {return}; print(self)
                        pressureFocusSelectionDialog?.dismiss()
                }
                pressureFocusSelectionDialog.onBtnDoneTapped = {
                        [ weak self] (preferenceData) in
                         guard let self = self else { return } ; print(self)
                        self.openDateTimeSelectionDialog()
                }
        }
    }
}
