//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
struct MyTherapistDetail{
    var name: String = ""
    var image: String = ""
    var isSelected: Bool = false
}
class MyTherapistTblCell: SelectionBorderTableCell {

   @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var imgTherapist: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.btnAction?.setTitle(FontSymbol.next_arrow, for: .normal)
        self.imgTherapist?.setRound()
    }

    func setData(data: MyTherapistDetail ) {
        super.setData(title: data.name, isSelected: data.isSelected)
        self.imgTherapist.downloadedFrom(link: data.image)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgTherapist?.setRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
