//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class SettingSwitchTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var ivIcon: UIImageView!

    @IBOutlet weak var btnEnable: ThemeButton!
    @IBOutlet weak var btnDisable: ThemeButton!

    @IBOutlet weak var vwTabEnable: UIView!
    @IBOutlet weak var vwTabDisable: UIView!
    @IBOutlet weak var vwSegment: UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnEnable?.setFont(name: FontName.Regular, size: FontSize.label_10)
        self.btnEnable?.setTitle("On", for: .normal)

        self.btnDisable?.setFont(name: FontName.Regular, size: FontSize.label_10)
        self.btnDisable?.setTitle("Off", for: .normal)

        self.imgSelected?.setRound()
        self.ivIcon?.setRound()


    }

    func setData(data: SettingPreferenceDetail ) {
        self.lblName.text = data.type.name()
        self.imgSelected.isHidden = !data.isSelected
        if data.isSelected {
            self.updateButton(button: btnEnable)
            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        } else {
            self.updateButton(button: btnDisable)
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        }

    }

    @IBAction func btnEnableTapped(_ sender: UIButton) {
        self.updateButton(button: btnEnable)
    }

    @IBAction func btnDisableTapped(_ sender: UIButton) {
        self.updateButton(button: btnDisable)
    }

    func updateButton(button: UIButton) {
        if button == btnEnable {
            vwTabEnable.isHidden = false
            vwTabDisable.isHidden = true
            btnEnable.setTitleColor(UIColor.themeLightTextColor, for: .normal)
            btnDisable.setTitleColor(UIColor.themePrimary, for: .normal)
        } else {
            vwTabEnable.isHidden = true
            vwTabDisable.isHidden = false
            btnDisable.setTitleColor(UIColor.themeLightTextColor, for: .normal)
            btnEnable.setTitleColor(UIColor.themePrimary, for: .normal)
        }
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivIcon?.setRound()
        self.imgSelected?.setRound()
        vwTabEnable?.setRound(withBorderColor: UIColor.clear, andCornerRadious: vwTabEnable.bounds.height/2, borderWidth: 1.0)
        vwSegment?.setRound(withBorderColor: UIColor.clear, andCornerRadious: vwSegment.bounds.height/2, borderWidth: 1.0)
        vwTabDisable?.setRound(withBorderColor: UIColor.clear, andCornerRadious: vwTabDisable.bounds.height/2, borderWidth: 1.0)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
