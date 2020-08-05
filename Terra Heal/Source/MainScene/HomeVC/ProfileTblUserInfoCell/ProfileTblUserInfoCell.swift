//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ProfileTblUserInfoCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!

    @IBOutlet weak var vwBg: UIView!
   @IBOutlet weak var btnAction: ThemeButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.label_26)
         self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.btnAction?.setHighlighted(isHighlighted: false)


    }

    func setData(data: HomeItemDetail ) {
        if data.title.isEmpty() {
            self.lblName.text = "HOME_LBL_HI".localized() + "HOME_LBL_USER".localized()
        }  else {
            self.lblName.text = "HOME_LBL_HI".localized() + data.title
        }
        self.btnAction.setTitle(data.buttonTitle, for: .normal)
        self.lblHeader.text = "HOME_INFO_LBL_1".localized()
        self.lblDescription.text = "HOME_INFO_LBL_2".localized()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnAction?.setHighlighted(isHighlighted: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
