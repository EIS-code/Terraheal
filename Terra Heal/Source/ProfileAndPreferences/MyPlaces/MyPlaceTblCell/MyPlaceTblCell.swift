//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit


class MyPlaceTblCell: SelectionBorderTableCell {


    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var ivForplace: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        
    }

    func setData(data: Place ) {
        super.setData(title: data.name, isSelected: data.isSelected)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
