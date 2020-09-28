//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class CustomChatDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var imgChatVw: UIImageView!
    
    var onBtnDoneTapped: (( ) -> Void)? = nil
    var selectedCampaignDetail: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:String = "", buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.lblDescription.text = data
        self.selectedCampaignDetail = data
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
        self.setDialogHeight(height: 0.95)
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
    
}


