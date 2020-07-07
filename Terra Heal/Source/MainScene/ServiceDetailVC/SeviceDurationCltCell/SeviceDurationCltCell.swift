//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

struct ServiceDurationDetail {
    var amount:String = ""
    var duration:String = ""
}

class SeviceDurationCltCell: CollectionCell {
    
    var data: ServiceDurationDetail!
    var parent: UIViewController? = nil
    
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
        vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
    }
 
}

