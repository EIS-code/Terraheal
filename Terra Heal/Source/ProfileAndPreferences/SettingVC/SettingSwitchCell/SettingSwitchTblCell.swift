//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class SettingSwitchTblCell: SelectionBorderTableCell {
    
  
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var vwSwitch: JDSegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwSwitch.allowChangeThumbWidth = false
        self.vwSwitch.itemTitles = ["enable","disable"]
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
    }
    
    func setData(data: SettingPreferenceDetail ) {
        super.setData(title: data.type.name(), isSelected: data.isSelected)
        self.ivIcon.image = UIImage.init(named: data.image)
        if data.strDetail.toBool {
            vwSwitch.selectItemAt(index: 0)
         } else  {
            vwSwitch.selectItemAt(index: 1)
        }
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vwSwitch.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwSwitch.bounds.height/2.0, borderWidth: 0.1)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
