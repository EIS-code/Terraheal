//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class ReciepentTblFooter: UITableViewHeaderFooterView {
    
    @IBOutlet weak var vwDashed: ThemeView!
    @IBOutlet weak var btnAddService: ThemeButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnAddService.setTitleColor(UIColor.themePrimary, for: .normal)
        btnAddService.backgroundColor = UIColor.themePrimaryLightBackground
        btnAddService.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        btnAddService.setTitle("RECIEPENT_BTN_ADD_SERVICE".localized(), for: .normal)
    }
    
    func setData(data: Any ) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnAddService?.layoutIfNeeded()
        self.btnAddService?.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: self.btnAddService.frame.height/2.0, borderWidth: 1.0)
        vwDashed?.createDashedLine(from: CGPoint.zero, to: CGPoint(x: vwDashed.bounds.maxX, y: 0), color: UIColor.themePrimary, strokeLength: 10, gapLength: 5, width: 1.0)
    }
    
   
}
