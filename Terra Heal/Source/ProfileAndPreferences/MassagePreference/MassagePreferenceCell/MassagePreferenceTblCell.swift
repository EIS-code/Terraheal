//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MassagePreferenceTblCell: SelectionBorderTableCell {
    @IBOutlet weak var btnAction: ThemeButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        
    }

    func setData(data: MassagePreferenceDetail ) {
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
