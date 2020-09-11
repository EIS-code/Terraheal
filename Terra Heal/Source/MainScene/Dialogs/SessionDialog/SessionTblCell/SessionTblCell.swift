//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class SessionTblCell: SelectionBorderTableCell {

    @IBOutlet weak var btnInfo: FloatingRoundButton!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblDetail: ThemeLabel!
    @IBOutlet weak var ivPicture: UIImageView!
    
    
    var data: SessionDetail = SessionDetail.init(fromDictionary: [:])
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.radius = 8
        self.cellBorderColor = UIColor.themePrimary
        self.shadowProperty.color = UIColor.init(hex: "#00000026")
        self.shadowProperty.opacity = 1.0
        self.shadowProperty.radius = 6
        self.shadowProperty.offset = CGSize.init(width: 0.0, height: 3.0)
        
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblDetail?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.ivPicture?.setRound()
    }

    func setData(data: SessionDetail ) {
        self.setData(title: "", isSelected: data.isSelected)
        self.data = data
        self.lblName.text = data.name
        self.lblDetail.text = data.detail
        self.ivPicture.image = UIImage.init(named: data.image)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivPicture?.setRound()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
