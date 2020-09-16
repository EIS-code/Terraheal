//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class PriceLocationTblCell: SelectionBorderTableCell {

    var data: PricingLocation = PricingLocation.init(fromDictionary: [:])
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(data: PricingLocation ) {
        self.data = data
        super.setData(title: data.name, isSelected: data.isSelected)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
