//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class FaqCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    func setData(data:String) {
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblName.text = data
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivUser?.layoutIfNeeded()
        self.ivUser?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
}




