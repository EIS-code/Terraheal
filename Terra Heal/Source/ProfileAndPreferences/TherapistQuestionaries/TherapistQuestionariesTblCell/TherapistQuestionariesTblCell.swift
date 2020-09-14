//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class TherapistQuestionariesTblCell: TableCell {

    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var txtQuestion: ACFloatingTextfield!
    @IBOutlet weak var lblTitle: ThemeLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.txtQuestion.disableFloatingLabel = true
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.txtQuestion.setFont(name: FontName.Regular, size: FontSize.detail)
    }

    func setData(data: QuestionDetail ) {
        self.lblTitle.text = data.title
        self.txtQuestion.placeholder = data.placeholder
        self.txtQuestion.text = data.value
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
