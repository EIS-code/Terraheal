//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ManagePeopleTblCell: TableCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblAge: ThemeLabel!
    @IBOutlet weak var lblGender: ThemeLabel!
    @IBOutlet weak var ivPeople: UIImageView!
    var data: People = People.init(fromDictionary: [:])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblAge?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblGender?.setFont(name: FontName.Bold, size: FontSize.label_18)
        
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        self.imgSelected?.setRound()
        self.ivPeople?.setRound()
    }
    
    func setData(data: People) {
        self.data = data
        self.lblName.text = data.name
        self.lblGender.text = data.getGenderName()
        self.lblAge.text = data.age
        self.ivPeople.downloadedFrom(link: data.photo)
        self.imgSelected.isHidden = !data.isSelected
        if self.data.isSelected {
            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
            
        } else {
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.data.isSelected {
            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
            
        } else {
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            
        }
        self.imgSelected?.setRound()
        self.ivPeople?.setRound()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
