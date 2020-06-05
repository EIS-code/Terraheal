//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



class MenuCellHorizontal: CollectionCell {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var ivBg: UIImageView!
    @IBOutlet weak var ivMenu: UIImageView!

    override class func awakeFromNib() {
        super.awakeFromNib()


    }

    func setData(menuDetail:MenuItem) {
        self.lblTitle?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblTitle.text = menuDetail.name

    }
    override func layoutSubviews() {
        super.layoutSubviews()

        self.ivMenu?.setRound()
        self.ivBg?.setRound(withBorderColor: .themePrimary, andCornerRadious: 20.0, borderWidth: 1.0)


    }
}




