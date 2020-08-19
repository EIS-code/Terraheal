//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
import Foundation


class CampaignsTblCell: TableCell {


    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var btnDetails: ThemeButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func setData(data: CampaignsDetail ) {
        self.btnDetails.setTitle("CAMPAIGNS_BTN_DETAILS".localized(), for: .normal)
        self.btnDetails.setFont(name: FontName.SemiBold, size: FontSize.button_14)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.btnDetails?.setupBorderedButton()
        

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
