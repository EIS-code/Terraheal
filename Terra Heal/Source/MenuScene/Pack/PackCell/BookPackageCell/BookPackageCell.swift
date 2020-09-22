//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class BookPackageCell: SelectionBorderTableCell {
    
    @IBOutlet weak var ivPack: UIImageView!
    @IBOutlet weak var lblId: ThemeLabel!
    @IBOutlet weak var lblDetail: ThemeLabel!
    @IBOutlet weak var btnBook: FilledRoundedButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.radius = 15
        self.lblId.setFont(name: FontName.Bold, size: FontSize.regular)
        self.lblDetail.setFont(name: FontName.Regular, size: FontSize.subHeader)
        
    }
    
    func setData(data: SubPackageDetail) {
        self.lblId.text = data.code
        self.lblDetail.text = data.description
        self.btnBook.setFont(name: FontName.Regular, size: FontSize.button_14)
        self.btnBook.setTitle("BTN_BOOK".localized(), for: .normal)
        self.btnBook.fillButton(textColor: UIColor.themeLightTextColor, backgroundColor: UIColor.themeSecondary, borderColor: .clear, buttonHeight: CommonSize.Button.cellButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivPack.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
