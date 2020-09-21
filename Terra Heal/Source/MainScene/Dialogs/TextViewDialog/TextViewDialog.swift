//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class TextViewDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var txtDescription: ThemeTextView!
    var strEnteredData: String = ""
    var onBtnDoneTapped: ((_ data:String) -> Void)? = nil
    var isMandatory: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    func initialize(title:String,data: String , buttonTitle:String,cancelButtonTitle:String, isMandatory:Bool = true) {
        self.initialSetup()
        self.isMandatory = isMandatory
        self.lblTitle.text = title
        self.txtDescription.text = data
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
        
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.txtDescription.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.txtDescription.setPlaceholderFont(name: FontName.Regular, size: FontSize.subHeader)
        self.txtDescription.placeholder = "Lorem ipsum dolor"
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.txtDescription?.delegate = self
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if isMandatory {
            strEnteredData = txtDescription.text?.trim() ?? ""
            if strEnteredData.isEmpty() {
                Common.showAlert(message: "VALIDATION_MSG_INVALID_DATA".localized())
            } else {
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!(strEnteredData);
                }
            }
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(strEnteredData);
            }
        }
    }
    
}

extension TextViewDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
}

