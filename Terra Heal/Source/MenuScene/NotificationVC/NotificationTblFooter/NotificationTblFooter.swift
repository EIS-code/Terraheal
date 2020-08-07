//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class NotificationTblFooter: UIView {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivIcon: UIImageView!



    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
    }

    func setData(data: SettingPreferenceDetail ) {
        self.lblName.text = data.type.name()
 }


    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
