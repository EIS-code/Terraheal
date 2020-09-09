//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct AddPackageDetail {
    var id: String = ""
    var name: String = ""
    var isSelected: Bool = false
    static func getDemoArrayForSelf() -> [AddPackageDetail] {
        let packDetail1: AddPackageDetail = AddPackageDetail.init(id: "0", name: "select center", isSelected: true)
        let packDetail2: AddPackageDetail = AddPackageDetail.init(id: "1",name: "select pack", isSelected: false)
        return [packDetail1,packDetail2]
    }
    static func getDemoArrayForGift() -> [AddPackageDetail] {
        let packDetail1: AddPackageDetail = AddPackageDetail.init(id: "0", name: "select center", isSelected: false)
        let packDetail2: AddPackageDetail = AddPackageDetail.init(id: "1",name: "select pack", isSelected: false)
        let packDetail3: AddPackageDetail = AddPackageDetail.init(id: "2",name: "recipients detail", isSelected: false)
        let packDetail4: AddPackageDetail = AddPackageDetail.init(id: "3",name: "giver details", isSelected: false)
        let packDetail5: AddPackageDetail = AddPackageDetail.init(id: "4",name: "sending preference", isSelected: false)
        return [packDetail1,packDetail2,packDetail3,packDetail4,packDetail5]
    }
}

class AddPackTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwDashed: UIView!
    @IBOutlet weak var imgSelected: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.header)
    }

    func setData(data: AddPackageDetail ) {
        self.lblName.text = data.name
        self.imgSelected.isHidden = !data.isSelected
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwDashed?.createDashedLine(from: CGPoint.zero, to: CGPoint(x: vwDashed.bounds.maxX, y: 0), color: UIColor.themePrimary, strokeLength: 10, gapLength: 5, width: 1.0)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
