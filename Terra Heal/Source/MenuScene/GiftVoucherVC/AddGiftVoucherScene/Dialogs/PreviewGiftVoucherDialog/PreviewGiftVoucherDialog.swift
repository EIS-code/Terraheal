//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit



class PreviewGiftVoucherDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var lblSubHeader: ThemeLabel!
    @IBOutlet weak var lblPrice: ThemeLabel!
    @IBOutlet weak var lblMassage: ThemeLabel!
    
    var onBtnDoneTapped: ((_ data: Voucher ) -> Void)? = nil
    var data: Voucher = Voucher()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:Voucher = Voucher(), buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = data.id
        self.setData(data: data)
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
    
    func setData(data: Voucher){
        self.lblHeader.text = data.getHeader()
        //self.lblSubHeader.text = data.subHeader
        //self.lblDescription.text = data.body
        self.lblPrice.text = data.amount.toCurrency()
        self.lblMassage.text = data.giverMessageToRecipient
        
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblHeader.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblSubHeader.setFont(name: FontName.SemiBold, size: FontSize.detail)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblPrice.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblMassage.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(data);
        }
    }
    
}


