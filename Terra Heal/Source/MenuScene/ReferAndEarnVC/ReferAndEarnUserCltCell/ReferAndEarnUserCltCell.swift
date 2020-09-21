//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class ReferAndEarnUserCltCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser.setRound()
    }
    func setData(data:String) {
        self.lblName?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblName.text = data



    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivUser?.layoutIfNeeded()
        self.ivUser?.setRound()
    }
}




