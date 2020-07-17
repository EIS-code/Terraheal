//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


class SettingTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var ivIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        self.imgSelected?.setRound()
        self.ivIcon?.setRound()
    }

    func setData(data: SettingPreferenceDetail ) {
        self.lblName.text = data.type.name()
        self.imgSelected.isHidden = !data.isSelected
        if data.isSelected {
            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        } else {
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        }

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg.layoutIfNeeded()
        self.ivIcon?.setRound()
        self.imgSelected?.setRound()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
