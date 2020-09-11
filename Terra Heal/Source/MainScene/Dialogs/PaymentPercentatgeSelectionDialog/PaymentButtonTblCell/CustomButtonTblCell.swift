//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


struct ButtonType {
    static var Large: Int = 0
    static var Small: Int = 1
}

struct CustomButtonDetail {
    var isSelected: Bool = false
    var id: Int = 0
    var title: String = ""
    var type: Int = ButtonType.Large
}


class CustomButtonTblCell: TableCell {

    @IBOutlet weak var btnDetail: ThemeButton!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivSelected: UIImageView!
    @IBOutlet weak var btnDetailLarge: ThemeButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnDetail?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.btnDetailLarge?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.ivSelected?.setRound()

    }

    func setData(data: CustomButtonDetail ) {
        self.btnDetail.setTitle(data.title, for: .normal)
        self.btnDetailLarge.setTitle(data.title, for: .normal)
        if data.isSelected {
            self.ivSelected.isHidden = false
            self.btnDetailLarge.isHidden = true
            self.btnDetail.isHidden = false
        } else {
            self.ivSelected.isHidden = true
            self.btnDetailLarge.isHidden = false
            self.btnDetail.isHidden = true
           
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivSelected?.setRound()
        self.btnDetail?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnDetailLarge?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
