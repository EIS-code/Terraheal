//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
struct SummaryValueDetail {
    var title: String = ""
    var subTitle: String = ""
    var value: String = ""
    static func getDemoArray() ->  [SummaryValueDetail]{
        let summary1:  SummaryValueDetail = SummaryValueDetail(title: "thai yoga massage", subTitle: "(90min) x1", value: "100")
        let summary2:  SummaryValueDetail = SummaryValueDetail(title: "hand or foot massage", subTitle: "(60min) x1", value: "90")
        return [summary1,summary2]
    }
}
class ReviewSummaryTblCell: TableCell {
    
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblSubTitle: ThemeLabel!
    @IBOutlet weak var lblValue: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblSubTitle.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblValue.setFont(name: FontName.Regular, size: FontSize.detail)
    }

    func setData(data: SummaryValueDetail ) {
        self.lblTitle.text = data.title
        self.lblSubTitle.text = data.subTitle
        self.lblValue.text = data.value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
