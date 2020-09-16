//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class CustomDistancePickerCell: SelectionBorderTableCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data: DistanceDetail ) {
        super.setData(title: data.type.name(), isSelected: data.isSelected)
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
