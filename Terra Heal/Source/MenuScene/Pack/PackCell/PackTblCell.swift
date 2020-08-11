//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class PackTblCell: TableCell {

    @IBOutlet weak var lblname: ThemeLabel!
    @IBOutlet weak var lblShortDescription: ThemeLabel!
    @IBOutlet weak var lblCode: ThemeLabel!
    @IBOutlet weak var lblVoucherCode: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var vwPromoCode: DashedLineView!
    @IBOutlet weak var ivPack: UIImageView!
    @IBOutlet weak var lblPackDetail: ThemeLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.lblVoucherCode.text = "PACK_CODE".localized()
        self.lblname?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblShortDescription?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.lblVoucherCode?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblCode?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblPackDetail?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.ivPack?.setRound()
       
    }

    func setData(data: PackDetail ) {
        self.lblCode.text = data.code
        self.lblShortDescription.text = data.description
        self.lblname.text = data.name
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.ivPack?.setRound()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
