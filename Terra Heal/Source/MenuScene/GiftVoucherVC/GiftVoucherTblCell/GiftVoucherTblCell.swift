//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class GiftVoucherTblCell: TableCell {

    @IBOutlet weak var lblname: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivPack: UIImageView!
    @IBOutlet weak var vwForgiftPack: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.ivPack?.setRound()
        self.vwForgiftPack.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    func setData(data: String ) {
       self.lblname.text = data
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.ivPack?.setRound()
        self.vwForgiftPack?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
