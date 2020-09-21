//  
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class ServiceCollapseCell: ServiceCell {

   override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblAddress?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblServices?.setFont(name: FontName.SemiBold, size: FontSize.detail)
        self.btnNumberOfServices?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnNumberOfServices?.setRound()
        self.btnHours.setTitle("BOOKING_OPENING_HOURS".localized(), for: .normal)
        self.lblServices.text = "BOOKING_SERVICES".localized()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnNumberOfServices?.setRound()
        self.ivMap?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
    }

}




