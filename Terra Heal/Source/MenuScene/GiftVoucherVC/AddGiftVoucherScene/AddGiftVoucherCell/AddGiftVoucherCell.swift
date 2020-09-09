//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class AddGiftVoucherCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblShortValue: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivMenu: UIImageView!
    @IBOutlet weak var ivSelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblShortValue?.setFont(name: FontName.Bold, size: FontSize.label_12)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.ivMenu?.setRound()
    }

    func setData(data: AddVouncherMenuDetail ) {
        self.lblName.text = data.type.name()
        self.lblShortValue.text = data.value.isEmpty() ? data.type.placeHolder() : data.value
        self.ivSelected.isHidden = !data.isSelected
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
