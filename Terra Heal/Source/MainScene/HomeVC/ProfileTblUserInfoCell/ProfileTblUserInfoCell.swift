//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ProfileTblUserInfoCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!

    @IBOutlet weak var vwBg: UIView!
   @IBOutlet weak var btnAction: RoundedBorderButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.detail)
    }

    func setData(data: HomeItemDetail ) {
        if data.title.isEmpty() {
            self.lblName.text = "HOME_LBL_HI".localized() + "HOME_LBL_USER".localized()
        }  else {
            self.lblName.text = "HOME_LBL_HI".localized() + data.title
        }
        self.btnAction.setTitle(data.buttonTitle, for: .normal)
        self.lblHeader.text = "HOME_INFO_LBL_1".localized()
        self.lblDescription.text = "HOME_INFO_LBL_2".localized()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        //self.openEventDialog()
        (self.parentVC as? HomeVC)?.updateEventData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func openEventDialog() {
        let alert: CustomAddNewEventDialog = CustomAddNewEventDialog.fromNib()
        alert.initialize(title:"events and corporate Booking", buttonTitle: "BTN_SEND".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (event) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            Common.appDelegate.loadCompleteVC(data: CompletionData.init(strHeader: "EVENT_BOOKING_TITLE".localized(), strMessage: "EVENT_BOOKING_MESSAGE".localized(), strImg: ImageAsset.Completion.requestBookingCompletion, strButtonTitle: "EVENT_BOOKING_BTN_HOME".localized()))
        }
        
        
        
        
    }
}
