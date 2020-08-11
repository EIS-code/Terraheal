//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class CustomChatDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!
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
         self.setDataForStepUpAnimation()
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.imgChatVw.layoutIfNeeded()
        self.imgChatVw?.setRound()
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
    
}


