//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

struct ServiceDurationDetail {
    var id:String = ""
    var amount:String = ""
    var duration:String = ""
    var isSelected: Bool = false
    static func getDemoArray() ->  [ServiceDurationDetail] {
        let serviceDurationDetail1 = ServiceDurationDetail(id: "1", amount: "100", duration: "120", isSelected: false)
        let serviceDurationDetail2 = ServiceDurationDetail(id: "2", amount: "120", duration: "140", isSelected: false)
        let serviceDurationDetail3 = ServiceDurationDetail(id: "3", amount: "140", duration: "160", isSelected: false)
        let serviceDurationDetail4 = ServiceDurationDetail(id: "4", amount: "200", duration: "80", isSelected: false)
        return[serviceDurationDetail1,serviceDurationDetail2,serviceDurationDetail3,serviceDurationDetail4]
    }
}

class SeviceDurationCltCell: CollectionCell {
    
    var data: ServiceDurationDetail!
    
    
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

