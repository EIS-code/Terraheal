//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomAmountTextFieldDialog: ThemeBottomDialogView {

    @IBOutlet weak var txtData: ACFloatingTextfield!


    var onBtnDoneTapped: ((_ data: String) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    func initialize(title:String, placeholder:String = "", data:String, buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.txtData.placeholder = placeholder
        self.txtData.text = data
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
        self.txtData?.placeholder = "".localized()
        self.txtData?.delegate = self
        self.configTextField(data: InputTextFieldDetail.getCurrencyConfiguration())
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

        return true
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.checkValidation() {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(txtData!.text!);
            }
        }
    }
    func configTextField(data:InputTextFieldDetail) {
        self.txtData.configureTextField(data)
    }

}

extension CustomAmountTextFieldDialog: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = textField.text! as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        let textArray = resultString.components(separatedBy: ".")
        if textArray.count > 2 { //Allow only one "."
              return false
        }
        if textArray.count == 2 {
           let lastString = textArray.last
           if lastString!.count > 2 { //Check number of decimal places
                 return false
             }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
