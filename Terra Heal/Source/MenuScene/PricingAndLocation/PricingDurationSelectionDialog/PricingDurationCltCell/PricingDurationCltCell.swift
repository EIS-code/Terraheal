//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



class PricingDurationCltCell: SelectionBorderCollectionCell {
    
    
    var data: ServiceDurationDetail!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var lblAmount: ThemeLabel!
    @IBOutlet weak var lblCurrencySign: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblAmount.setFont(name: FontName.Bold, size: FontSize.exLarge)
        self.lblDuration.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblCurrencySign.setFont(name: FontName.Bold, size: FontSize.small)
    }
    
    func setData(data:ServiceDurationDetail) {
        super.setData(isSelected: data.isSelected)
        self.data = data
        self.lblDuration.text = data.time + " " + "TIME_UNIT_MIN".localized()
        self.lblAmount.text = data.pricing.price
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}

