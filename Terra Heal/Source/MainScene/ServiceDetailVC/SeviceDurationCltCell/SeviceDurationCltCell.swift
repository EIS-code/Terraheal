//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



class SeviceDurationCltCell: CollectionCell {
    
    var data: ServiceDurationDetail!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var lblAmount: ThemeLabel!
    @IBOutlet weak var lblCurrencySign: ThemeLabel!

    struct Radius {
        static let value = 10
        static let border = 1
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblAmount.setFont(name: FontName.Bold, size: FontSize.exLarge)
        self.lblDuration.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblCurrencySign.setFont(name: FontName.Bold, size: FontSize.label_10)
    }
    
    func setData(data:ServiceDurationDetail) {
        self.data = data
        self.lblDuration.text = data.time + " " + "TIME_UNIT_MIN".localized()
        self.lblAmount.text = data.pricing.price
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        vwBg?.setRound(withBorderColor: .themeHintText, andCornerRadious: JDDeviceHelper.offseter(offset: 10), borderWidth: 1.0)
        vwBg?.setDurationCellShadow()
    }
 
}

