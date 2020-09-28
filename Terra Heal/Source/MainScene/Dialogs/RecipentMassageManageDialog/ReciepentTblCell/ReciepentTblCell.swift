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
    @IBOutlet weak var lblPrice: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnDelete.backgroundColor = UIColor.white
        self.lblName.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblDuration.setFont(name: FontName.Regular, size: FontSize.detail)
         self.lblPrice.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    
    func setData(data: ServiceDetail ) {
        self.lblName.text = data.name
        self.lblDuration.text = data.selectedDuration.time + " " + "min"
        self.lblPrice.text = data.selectedDuration.pricing.price.toCurrency()
    }
    
    func setPackServiceData(data: PackService ) {
        self.lblName.text = data.name
        self.lblDuration.text = data.time + " " + "min"
        self.lblPrice.text = data.amount.toCurrency()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnDelete.setRound()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
