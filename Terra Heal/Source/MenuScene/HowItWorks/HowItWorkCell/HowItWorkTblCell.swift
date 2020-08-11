//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class HowItWorkTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblShortDescription: ThemeLabel!
    @IBOutlet weak var lblLongDescription: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivMenu: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblShortDescription?.setFont(name: FontName.Bold, size: FontSize.label_12)
        self.lblLongDescription?.setFont(name: FontName.Bold, size: FontSize.label_12)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.ivMenu?.setRound()
    }

    func setData(data: HowItworkMenuDetail ) {
        self.lblName.text = data.type.name()
        self.lblShortDescription.text = data.shortDescription
        self.lblLongDescription.text = data.description
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.ivMenu?.setRound()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
