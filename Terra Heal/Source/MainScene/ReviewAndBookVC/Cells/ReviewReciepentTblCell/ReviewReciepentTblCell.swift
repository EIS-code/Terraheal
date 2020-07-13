//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
class ReviewReciepentTblCell: TableCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblDuration.setFont(name: FontName.Regular, size: FontSize.label_14)
    }
    
    func setData(data: ServiceDetail ) {
        self.lblName.text = data.name
        self.lblDuration.text = data.selectedDuration.duration + " " + "min"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
