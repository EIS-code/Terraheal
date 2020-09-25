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


class CustomButtonTblCell: SelectionBorderTableCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCellTitle.textColor = UIColor.themeDarkText
    }

    func setData(data: CustomButtonDetail ) {
        super.setData(title: data.title, isSelected: data.isSelected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
