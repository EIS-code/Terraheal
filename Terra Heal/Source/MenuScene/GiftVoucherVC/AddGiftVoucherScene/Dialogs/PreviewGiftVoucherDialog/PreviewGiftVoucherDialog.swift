//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


struct GiftVoucherDetail {
    var header: String = "to suravshing tomar, from Prince"
    var subHeader: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do"
    var body: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis urna id volutpat lacus laoreet. Mauris vitae ultricies leo integer malesuada."
    var price:String = "100$"
    var massage: String = "Thai Massage"
    var image: UIImage = UIImage()
}

class PreviewGiftVoucherDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var lblSubHeader: ThemeLabel!
    @IBOutlet weak var lblPrice: ThemeLabel!
    @IBOutlet weak var lblMassage: ThemeLabel!
    
    var onBtnDoneTapped: ((_ data: GiftVoucherDetail ) -> Void)? = nil
    var data: GiftVoucherDetail = GiftVoucherDetail()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:GiftVoucherDetail = GiftVoucherDetail(), buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.lblHeader.text = data.header
        self.lblSubHeader.text = data.subHeader
        self.lblDescription.text = data.body
        self.lblPrice.text = data.price
        self.lblMassage.text = data.massage
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
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblHeader.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblSubHeader.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblPrice.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblMassage.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.btnCancel.setTitleColor(UIColor.themeDarkText, for: .normal)
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(data);
        }
    }
    
}


