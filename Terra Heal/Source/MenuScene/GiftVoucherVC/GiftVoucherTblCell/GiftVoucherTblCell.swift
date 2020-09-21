//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class GiftVoucherTblCell: ShadowTableCell {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblId: ThemeLabel!
    @IBOutlet weak var lblPrice: ThemeLabel!
    @IBOutlet weak var lblDate1: ThemeLabel!
    @IBOutlet weak var lblDate2: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowProperty.radius = 4.0
        self.shadowProperty.color = UIColor.init(hex: "#B2B3B566")
        self.shadowProperty.offset = CGSize.init(width: 0.0, height: 0.0)
        self.vwBg.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 25), borderWidth: 1.0)
        self.lblId.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblPrice.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblDate1.setFont(name: FontName.Bold, size: FontSize.regular)
        self.lblDate2.setFont(name: FontName.Bold, size: FontSize.regular)
    }

    func setData(data: GiftVoucherDetail ) {
        self.lblId.text = data.id
        self.lblPrice.text = data.price
        self.lblDate1.text = data.date1
        self.lblDate2.text = data.date2
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow()
        self.vwBg.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 25), borderWidth: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
