//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
class ReviewReciepentTblSection: UITableViewHeaderFooterView {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblAge: ThemeLabel!
    @IBOutlet weak var lblGender: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblAge.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblGender.setFont(name: FontName.SemiBold, size: FontSize.label_18)
    }
    
    
    func setData(data: People ) {
        self.lblName.text = data.name
        self.lblAge.text = data.age
        self.lblGender.text = data.getGenderName()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
 
}
