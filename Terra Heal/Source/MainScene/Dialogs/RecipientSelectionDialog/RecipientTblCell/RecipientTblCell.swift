//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class RecipientTblCell: SelectionBorderTableCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var lblAge: ThemeLabel!
    @IBOutlet weak var lblGender: ThemeLabel!
    @IBOutlet weak var ivPeople: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblAge?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblGender?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        self.ivPeople?.setRound()
        self.shadowProperty.color = UIColor.init(hex: "#00000026")
        self.shadowProperty.opacity = 1.0
        self.shadowProperty.offset = CGSize.init(width: 0.0, height: 3.0)
        
    }
    
    func setData(data: People) {
        self.setData(title: "", isSelected: data.isSelected)
        self.lblName.text = data.name
        self.lblGender.text = data.getGenderName()
        self.lblAge.text = data.age
        self.ivPeople.downloadedFrom(link: data.photo)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivPeople?.setRound()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
