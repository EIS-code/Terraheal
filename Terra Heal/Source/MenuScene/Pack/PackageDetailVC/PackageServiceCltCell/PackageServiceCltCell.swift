//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class PackageServiceCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivService: UIImageView!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var ivCellSelected: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ivService?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblDuration?.setFont(name: FontName.SemiBold, size: FontSize.regular)
    }
    func setData(data:PackageServiceDetail) {
        self.contentView.alpha = data.isUsed ? 0.5 : 1.0
        if data.isSelected {
            self.ivService?.setRound(withBorderColor: .themePrimary, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
            self.ivCellSelected.isHidden = false
        } else {
            self.ivService?.setRound(withBorderColor: .clear, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
            self.ivCellSelected.isHidden = true
        }
        self.lblName.text = data.name
        self.lblDuration.text = data.duration + "\n" + "mins"
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}




