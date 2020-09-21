//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class PackTblCell: SelectionBorderTableCell {
    
    @IBOutlet weak var ivPack: UIImageView!
    @IBOutlet weak var lblId: ThemeLabel!
    @IBOutlet weak var lblDetail: ThemeLabel!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblDate: ThemeLabel!
    @IBOutlet weak var lblPrice: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.radius = 25
        self.shadowProperty.radius = 4.0
        self.shadowProperty.color = UIColor.init(hex: "#B2B3B566")
        self.shadowProperty.offset = CGSize.init(width: 0.0, height: 0.0)
        
        self.lblId.setFont(name: FontName.Bold, size: FontSize.regular)
        self.lblDetail.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.lblName.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.lblDate.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblPrice.setFont(name: FontName.SemiBold, size: FontSize.header)
    }
    
    func setData(data: PackDetail ) {
        super.setData(title: "", isSelected: data.isSelected)
        self.lblId.text = data.code
        self.lblDetail.text = data.description
        self.lblName.text = data.name
        self.lblDate.text = data.date
        self.lblPrice.text = data.price
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
