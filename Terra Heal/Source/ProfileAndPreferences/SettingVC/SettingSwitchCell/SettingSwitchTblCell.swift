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
    @IBOutlet weak var vwSwitch: JDSegmentedControl!
    @IBOutlet weak var vwImgBg: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.vwSwitch.allowChangeThumbWidth = false
        self.vwSwitch.itemTitles = ["Enable","Disable"]
        self.vwSwitch.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwSwitch.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {return} ; print(self)
            var request: SettingPreference.SaveSettingPrefence = SettingPreference.SaveSettingPrefence()
            if index == 0 {
                request.notification = Constant.True
            } else {
                request.notification = Constant.False
            }
            (self.parentVC as? SettingVC)?.wsUpdateSettingDetail(request: request)
        }
        self.imgSelected?.setRound()
        self.vwImgBg?.setRound()
        
        
    }
    
    func setData(data: SettingPreferenceDetail ) {
        self.lblName.text = data.type.name()
        self.imgSelected.isHidden = !data.isSelected
        self.ivIcon.image = UIImage.init(named: data.image)
        if data.strDetail.toBool {
            vwSwitch.selectItemAt(index: 0)
            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        } else  {
            vwSwitch.selectItemAt(index: 1)
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        }
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwImgBg?.setRound()
        self.imgSelected?.setRound()
        vwSwitch.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwSwitch.bounds.height/2.0, borderWidth: 0.1)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
