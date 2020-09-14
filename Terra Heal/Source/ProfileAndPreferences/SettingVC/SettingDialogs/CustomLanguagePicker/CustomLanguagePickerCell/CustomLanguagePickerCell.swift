//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class CustomLanguagePickerCell: SelectionBorderTableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblFlag: ThemeLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.radius = 15
               self.cellBorderColor = UIColor.themePrimary
               self.shadowProperty.color = UIColor.init(hex: "#3C80D116")
               self.shadowProperty.opacity = 1.0
               self.shadowProperty.radius = 19
               self.shadowProperty.offset = CGSize.init(width: 0.0, height: 12.0)
        //self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
      
    }

    func setData(data: LanguageDetail ) {
        self.lblName.text = data.name
        self.lblFlag.text = data.image
        super.setData(title: data.name, isSelected: data.isSelected)


    }

    override func layoutSubviews() {
        super.layoutSubviews()
       // self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
