//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
class ReciepentTblCell: TableCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var btnDelete: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(data: ServiceDetail ) {
        self.lblName.text = data.name
        self.lblDuration.text = data.duration[0].duration + " " + "min"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
