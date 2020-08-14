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
    @IBOutlet weak var txtQuestion: EditProfileTextfield!


    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        /*txtQuestion.textColor = .themePrimary
        txtQuestion.selectedPlaceHolderColor = .themePrimary
        txtQuestion.placeHolderColor = .themePrimary
        txtQuestion.leftViewColor = .themePrimary
        txtQuestion.lineColor = .themePrimary
        txtQuestion.selectedLineColor = .themePrimary*/

    }

    func setData(data: HelpDetail ) {
        self.txtQuestion.placeholder = data.question
        self.txtQuestion.text = data.answer

    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
