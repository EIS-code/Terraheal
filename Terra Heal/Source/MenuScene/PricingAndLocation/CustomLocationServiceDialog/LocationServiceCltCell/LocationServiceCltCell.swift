//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class LocationServiceCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivUser: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    func setData(data:ServiceDetail) {
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblName.text = data.name
        self.btnFavourite.isSelected = data.isSelected
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivUser?.layoutIfNeeded()
        self.ivUser?.setRound(withBorderColor: .themeHintText, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    @IBAction func btnFavouriteTapped(_ sender: Any) {
        self.btnFavourite.isSelected.toggle()
    }
}




