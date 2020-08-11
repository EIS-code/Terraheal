//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

struct ShareReferral {
    var referralHeader: String = "hello,\nVirendra has\nrecommended\nyou to terra heal"
    var description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis"
    var image: UIImage = UIImage()
}
class CustomShareReferralDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!
    
    var onBtnDoneTapped: ((_ data: ShareReferral ) -> Void)? = nil
    var shareReferral: ShareReferral = ShareReferral()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:ShareReferral = ShareReferral(), buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.lblHeader.text = data.referralHeader
        self.lblDescription.text = data.description
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
        self.lblHeader.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(shareReferral);
        }
    }
    
}


