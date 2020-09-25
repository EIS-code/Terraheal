//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation


class TherapistCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var ivCellSelected: UIImageView!
    var data:MyTherapistDetail? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser.setRound()
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.detail)
        
    }
    func setData(data:MyTherapistDetail) {
        self.lblName.text = data.name
        self.ivUser.downloadedFrom(link: data.image)
        self.data = data
        if data.isSelected {
            self.ivUser.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: 0.0, borderWidth: 1.0)
            self.ivCellSelected.isHidden = false
        } else {
            self.ivUser.setRound(withBorderColor: UIColor.clear, andCornerRadious: 0.0, borderWidth: 1.0)
            self.ivCellSelected.isHidden = true
        }


    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivUser?.layoutIfNeeded()
        if (data?.isSelected) ?? false {
            self.ivUser.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: 0.0, borderWidth: 1.0)
        } else {
            self.ivUser.setRound(withBorderColor: UIColor.clear, andCornerRadious: 0.0, borderWidth: 1.0)
        }
    }
}




