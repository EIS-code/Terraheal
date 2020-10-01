//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class HelpTblCell: TableCell {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblCellTitle: ThemeLabel!
    @IBOutlet weak var lblCellValue: ThemeLabel!
    @IBOutlet weak var ivCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblCellTitle.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblCellValue.setFont(name: FontName.Regular, size: FontSize.detail)
        /*txtQuestion.textColor = .themePrimary
        txtQuestion.selectedPlaceHolderColor = .themePrimary
        txtQuestion.placeHolderColor = .themePrimary
        txtQuestion.leftViewColor = .themePrimary
        txtQuestion.lineColor = .themePrimary
        txtQuestion.selectedLineColor = .themePrimary*/

    }

    func setData(data: HelpDetail ) {
        self.ivCell.image = UIImage.init(named: data.image)
        self.lblCellTitle.text = data.question
        self.lblCellValue.text = data.answer

    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
