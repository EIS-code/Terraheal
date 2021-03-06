//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ReferAndEarnTblCell: TableCell {

    @IBOutlet weak var lblDay: ThemeLabel!
    @IBOutlet weak var lblMonth: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var lblAmount: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!



    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblDay.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblMonth.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblAmount.setFont(name: FontName.Bold, size: FontSize.header)
    }

    func setData(data: ReferralDetail ) {
        self.lblDescription.text = data.description
        self.lblAmount.text = data.amount.toCurrency()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
