//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class CreditCardTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var btnDefult: ThemeButton!
    @IBOutlet weak var ivCard: UIImageView!
    @IBOutlet weak var lblCardValue: ThemeLabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.ivCard.setRound()
    }

    func setData(data: CreditCardDetail ) {
        self.lblName.text = data.name
        self.lblCardValue.text = data.value
        self.btnDefult.isHidden = data.isSeleced
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivCard?.setRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}