//
//  KycInfoTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
struct HomeItemDetail {
    var title: String = ""
    var buttonTitle: String = ""
    var image: String = ""
}
class HomeTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivHome: UIImageView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var vwBg: UIView!



    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.ivHome?.setRound()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnAction?.setHighlighted(isHighlighted: true)
    }

    func setData(data: HomeItemDetail ) {
        self.lblName.text = data.title
        self.btnAction.setTitle(data.buttonTitle, for: .normal)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivHome?.setRound()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnAction?.setHighlighted(isHighlighted: true)


    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
