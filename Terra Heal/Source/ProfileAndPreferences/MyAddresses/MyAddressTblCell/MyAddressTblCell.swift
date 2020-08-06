//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MyAddressTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblAddress: ThemeLabel!
    @IBOutlet weak var btnEdit: FloatingRoundButton!
    @IBOutlet weak var btnDelete: FloatingRoundButton!



    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_22)
          self.lblAddress?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)


    }

    func setData(data: Address ) {
        self.lblName.text = data.name
        self.lblAddress.text = data.addressLine1 + "\n" + data.addressLine2 + "\n" + data.city +  "-" + data.pinCode
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
