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


    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

    }

    func setData(data: TherapistQuesionDetail ) {
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
