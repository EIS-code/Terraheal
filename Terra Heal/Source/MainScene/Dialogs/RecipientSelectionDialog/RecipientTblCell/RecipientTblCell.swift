//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class RecipientTblCell: TableCell {

     @IBOutlet weak var lblName: ThemeLabel!
       @IBOutlet weak var vwBg: UIView!
       @IBOutlet weak var btnAction: ThemeButton!
       @IBOutlet weak var imgSelected: UIImageView!
       @IBOutlet weak var lblAge: ThemeLabel!
       @IBOutlet weak var lblGender: ThemeLabel!
       @IBOutlet weak var ivPeople: UIImageView!


       override func awakeFromNib() {
           super.awakeFromNib()
           selectionStyle = .none
           self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
           self.lblAge?.setFont(name: FontName.Bold, size: FontSize.label_18)
           self.lblGender?.setFont(name: FontName.Bold, size: FontSize.label_18)

           self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
           self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
           self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
           self.imgSelected?.setRound()
           self.ivPeople?.setRound()
       }

       func setData(data: People) {
           self.lblName.text = data.name
           self.lblGender.text = data.getGenderName()
           self.lblAge.text = data.age
           self.ivPeople.downloadedFrom(link: data.photo)
           self.imgSelected.isHidden = !data.isSelected
       }

       override func layoutSubviews() {
           super.layoutSubviews()
           self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
           self.imgSelected?.setRound()
           self.ivPeople?.setRound()
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           // Configure the view for the selected state
       }
}
