//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
enum HomeItemType: Int {
    case MassageCenter = 0
    case HotelOrRoom = 1
    case EventAndCorporate = 2
}
struct HomeItemDetail {
    var title: String = ""
    var buttonTitle: String = ""
    var image: String = ""
    var homeItemtype: HomeItemType = .MassageCenter
}
class HomeTblCell: TableCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivHome: UIImageView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var vwBg: UIView!
    var data: HomeItemDetail!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.btnAction?.setHighlighted(isHighlighted: false)
    }
    
    func setData(data: HomeItemDetail ) {
        self.lblName.text = data.title
        self.data = data
        self.btnAction.setTitle(data.buttonTitle, for: .normal)
        self.ivHome?.image = UIImage.init(named: data.image)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.vwBg?.setShadow()
        self.btnAction?.setHighlighted(isHighlighted: false)
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func btnBookNowTaaped(_ sender: Any) {
        switch self.data.homeItemtype {
        case .MassageCenter:
            self.openEventDialog()
        case .HotelOrRoom:
            self.openInfoDialog()
        case .EventAndCorporate:
            self.openEventDialog()
         }
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
    
    func openInfoDialog() {
        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()
        alert.initialize(title: "HOME_ITEM_TYPE_INFO".localized(), message: "HOME_ITEM_TYPE_HOTEL_OR_ROOM".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }
}
