//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
struct MassageCellDetail {
    var title: String = ""
    var subTitle:String = ""
    init(data:ServiceDetail) {
        self.title = data.name
        self.subTitle = data.selectedDuration.time + " " + "min"
    }
    init(data:MyBookingMassage) {
        self.title = data.name
        self.subTitle = data.time + " " + "min"
    }

    init(title:String?, subTitle:String?) {
        self.title = title ?? ""
        self.subTitle = subTitle ?? ""
    }
}
class MassageDetailTblCell: TableCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblDuration.setFont(name: FontName.Regular, size: FontSize.detail)
    }
    
    func setData(data: MassageCellDetail ) {
        self.lblName.text = data.title
        self.lblDuration.text = data.subTitle
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
