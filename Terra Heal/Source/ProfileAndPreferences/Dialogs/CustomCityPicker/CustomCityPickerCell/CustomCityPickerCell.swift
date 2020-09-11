//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class CustomCityPickerCell: SelectionBorderTableCell {



    override func awakeFromNib() {
        super.awakeFromNib()
        self.radius = 15
        self.cellBorderColor = UIColor.themePrimary
        self.shadowProperty.color = UIColor.init(hex: "#3C80D116")
        self.shadowProperty.opacity = 1.0
        self.shadowProperty.radius = 19
        self.shadowProperty.offset = CGSize.init(width: 0.0, height: 12.0)
      
    }

    func setData(data: City ) {
        self.setData(title: data.name, isSelected: data.isSelected)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
