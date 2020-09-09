//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class CustomCampaignsDetailDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var imgChatVw: UIImageView!

    var onBtnDoneTapped: ((_ data: CampaignsDetail ) -> Void)? = nil
    var selectedCampaignDetail: CampaignsDetail = CampaignsDetail()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:CampaignsDetail = CampaignsDetail(name:"",description:"CAMPAIGNS_DETAIL_DIALOG_MSG".localized()), buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.lblHeader.text = data.name
        self.lblDescription.text = data.description
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
        
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblHeader.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setDataForStepUpAnimation()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //self.scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedCampaignDetail);
            }
    }

}


