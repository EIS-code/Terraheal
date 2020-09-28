//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct SelectionCellDetailWithImage {
    var image: String = ""
    var name: String = ""
    var id: String = ""
    var isSelected = false
    
}

class BookingTypeSelectionCell: SelectionBorderTableCell {
    @IBOutlet weak var imgBookType: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCellTitle.textColor = UIColor.themeDarkText
    }

    func setData(data: SelectionCellDetailWithImage ) {
        super.setData(title: data.name, isSelected: data.isSelected)
        self.imgBookType.image = UIImage.init(named: data.image)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
