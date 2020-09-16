//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class AddPaymentTblCell: SelectionBorderTableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(data: CustomButtonDetail) {
        self.setData(title: data.title, isSelected: data.isSelected)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
