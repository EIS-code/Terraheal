//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

struct MyBookingTblCellDetail {
    var title: String = ""
    var image: String = ""
    var isSelected:Bool = false

    init(data:MyBookingData) {
        self.title = Date.milliSecToDate(milliseconds: data.massageDate.toDouble, format: DateFormat.MyBookingCollapseDate)
    }
}

class MyBookingTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwCollapse: UIView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var ivForCell: UIImageView!
    @IBOutlet weak var vwBar: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
     }

    func setData(data: MyBookingTblCellDetail ) {
        self.lblName.text = data.title
        self.vwBar.backgroundColor =  data.isSelected ? UIColor.green : UIColor.red
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}



