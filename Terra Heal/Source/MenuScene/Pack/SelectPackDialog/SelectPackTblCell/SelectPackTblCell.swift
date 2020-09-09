//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct PackageDetail {
    var id: String = ""
    var name: String = ""
    var price: String = ""
    var discount: String = ""
    var isSelected: Bool = false
    static func getDemoArray() -> [PackageDetail] {
        let packDetail1: PackageDetail = PackageDetail.init(id: "0", name: "five 60 min\nmassages", price: "350$", discount: "save 180$", isSelected: true)
        let packDetail2: PackageDetail = PackageDetail.init(id: "1",name: "five 90 min\nmassages", price: "220$", discount: "save 120$", isSelected: false)
        let packDetail3: PackageDetail = PackageDetail.init(id: "2",name: "five 40 min\nmassages", price: "430$", discount: "save 420$", isSelected: false)
        let packDetail4: PackageDetail = PackageDetail.init(id: "3",name: "five 90 min\nmassages", price: "220$", discount: "save 230$", isSelected: false)
        return [packDetail1,packDetail2,packDetail3,packDetail4]
    }
}
class SelectPackTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblPrice: ThemeLabel!
    @IBOutlet weak var lblDiscount: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var ivSelected: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.lblPrice?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.lblDiscount?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.ivSelected?.setRound()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    func setData(data: PackageDetail ) {
        self.lblName.text = data.name
        self.lblPrice.text = data.price
        self.lblDiscount.text = data.price
        if data.isSelected {
            self.ivSelected.isHidden = false
            self.vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 10.0, borderWidth: 1.0)
        } else {
            self.ivSelected.isHidden = true
            self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivSelected?.setRound()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
