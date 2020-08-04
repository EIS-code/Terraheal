//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class CustomAddNewAddressDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var txtAddressLine1: ACFloatingTextfield!
    @IBOutlet weak var txtAddressLine2: ACFloatingTextfield!
    @IBOutlet weak var txtLandmark: ACFloatingTextfield!
    @IBOutlet weak var txtPincode: ACFloatingTextfield!
    @IBOutlet weak var txtCity: ACFloatingTextfield!
    @IBOutlet weak var txtState: ACFloatingTextfield!
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var btnMapLocation: FloatingRoundButton!
    @IBOutlet weak var txtLatitude: ACFloatingTextfield!
    @IBOutlet weak var txtLongitude: ACFloatingTextfield!
    
    var onBtnDoneTapped: ((_ data: Address ) -> Void)? = nil
    var selectedAddress: Address = Address.init(fromDictionary: [:])
    var locationVC: MapLocationVC? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:Address, buttonTitle:String,cancelButtonTitle:String) {
        
        self.selectedAddress = data
        self.initialSetup()
        self.lblTitle.text = title
        self.setAddressData(data: data)
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
    func setAddressData(data:Address) {
        self.txtCity.text = data.city
        self.txtState.text = data.province
        self.txtName.text = data.name
        self.txtLatitude.text = data.latitude
        self.txtLongitude.text = data.longitude
        self.txtAddressLine1.text = data.addressLine1
        self.txtAddressLine2.text = data.addressLine2
        self.txtLandmark.text = data.landMark
        self.txtPincode.text = data.pinCode
       
    }
    override func initialSetup() {
        super.initialSetup()
        self.txtAddressLine1?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_LINE_1".localized()
        self.txtAddressLine1.delegate = self
        self.txtAddressLine2?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_LINE_2".localized()
        self.txtAddressLine2.delegate = self
        self.txtLandmark?.placeholder = "MANAGE_ADDRESS_TXT_LANDMARK".localized()
        self.txtLandmark.delegate = self
        self.txtPincode?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_PINCODE".localized()
        self.txtPincode.delegate = self
        self.txtCity?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_CITY".localized()
        self.txtCity.delegate = self
        self.txtState?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_STATE".localized()
        self.txtState.delegate = self
        self.txtName?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_NAME".localized()
        self.txtName.delegate = self
        self.txtLatitude?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_LATITUDE".localized()
        self.txtLatitude.delegate = self
        self.txtLongitude?.placeholder = "MANAGE_ADDRESS_TXT_ADDRESS_LONGITUDE".localized()
        self.txtLongitude.delegate = self
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setDataForStepUpAnimation()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    func checkValidation() -> Bool {
        if txtAddressLine1.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtAddressLine1.becomeFirstResponder()
            }
            return false
        }
        else if txtLandmark.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtLandmark.becomeFirstResponder()
            }
            return false
        }
        else if txtPincode.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtPincode.becomeFirstResponder()
            }
            return false
        }
        else if txtCity.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtCity.becomeFirstResponder()
            }
            return false
        }
        else if txtState.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_DATA".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtState.becomeFirstResponder()
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
            selectedAddress.addressLine1 = txtAddressLine1.text ?? ""
            selectedAddress.addressLine2 = txtAddressLine2.text ?? ""
            selectedAddress.landMark = txtLandmark.text ?? ""
            selectedAddress.city = txtCity.text ?? ""
            selectedAddress.province = txtState.text ?? ""
            selectedAddress.pinCode = txtPincode.text ?? ""
            selectedAddress.name = txtName.text ?? ""
            selectedAddress.latitude = txtLatitude.text ??  "22.30"
            selectedAddress.longitude = txtLatitude.text ??  "70.30"
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedAddress);
            }
        }
    }
   
    @IBAction func btnLocationTapped(_ sender: ThemeButton) {
        if locationVC == nil {
             locationVC = MapLocationVC.fromNib()
        }
        Common.appDelegate.getTopViewController()?.present(locationVC!, animated: true, completion: {
            
        })
        locationVC?.onLocationSelected =  { [weak self, weak locationVC = locationVC] (address) in
           
            guard let self = self else {
                return
            }
            let id = self.selectedAddress.id
            self.selectedAddress = address
            self.selectedAddress.id = id 
            DispatchQueue.main.async {
                self.setAddressData(data: self.selectedAddress)
            }
            locationVC?.dismiss(animated: true, completion: {
            })
        }
    }
    
}

extension CustomAddNewAddressDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
