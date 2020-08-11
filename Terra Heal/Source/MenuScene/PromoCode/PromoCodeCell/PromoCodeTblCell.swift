//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class PromoCodeTblCell: TableCell {

    @IBOutlet weak var lblExpiry: ThemeLabel!
    @IBOutlet weak var lblShortDescription: ThemeLabel!
    @IBOutlet weak var lblCode: ThemeLabel!
    @IBOutlet weak var lblVoucherCode: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var vwPromoCode: DashedLineView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.lblVoucherCode.text = "PROMOCODE_VOUCHER_CODE".localized()
        self.lblExpiry?.setFont(name: FontName.SemiBold, size: FontSize.label_12)
        self.lblShortDescription?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.lblVoucherCode?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblCode?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
       
    }

    func setData(data: PromocodeDetail ) {
        self.lblCode.text = data.code
        self.lblShortDescription.text = data.description
        self.lblExpiry.text = data.expiry
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
       /* self.vwPromoCode?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.vwPromoCode.createDashedLine(color: .themePrimary, strokeLength: 4.0, gapLength: 4.0, width: 1.0)*/
        

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
