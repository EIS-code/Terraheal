//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class HowItWorkTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblShortDescription: ThemeLabel!
    @IBOutlet weak var lblLongDescription: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivMenu: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblShortDescription?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblLongDescription?.setFont(name: FontName.Regular, size: FontSize.detail)
    
    }

    func setData(data: MenuItemDetail ) {
        self.lblName.text = data.title
        self.lblShortDescription.text = data.shortDescription
        self.lblLongDescription.text = data.detail
        self.ivMenu.downloadedFrom(link: data.icon)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
