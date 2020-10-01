//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class AddGiftVoucherCell: SelectionBorderTableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblShortValue: ThemeLabel!
    @IBOutlet weak var ivMenu: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblShortValue?.setFont(name: FontName.Bold, size: FontSize.detail)
        
    }

    func setData(data: AddVouncherMenuDetail ) {
        self.lblName.text = data.type.name()
        self.lblShortValue.text = data.value.isEmpty() ? data.type.placeHolder() : data.value
        self.ivMenu.image = UIImage.init(named: data.type.image())
        super.setData(title: data.type.name(), isSelected: data.isSelected)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
