//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



class DurationCltCell: CollectionCell {
    
    
    var data: ServiceDurationDetail!
    
    @IBOutlet weak var ivSelected: PaddedImageView!
    
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblDuration: ThemeLabel!
    @IBOutlet weak var lblAmount: ThemeLabel!
    @IBOutlet weak var lblCurrencySign: ThemeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblAmount.setFont(name: FontName.Bold, size: FontSize.label_36)
        self.lblDuration.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblCurrencySign.setFont(name: FontName.Bold, size: FontSize.label_10)
    }
    
    func setData(data:ServiceDurationDetail) {
        self.data = data
        self.lblDuration.text = data.duration
        self.lblAmount.text = data.amount
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivSelected?.setRound()
        if data.isSelected {
            self.ivSelected?.isHidden = false
            vwBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
        } else  {
            self.ivSelected?.isHidden = true
            vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
        }
        
    }
    
}

