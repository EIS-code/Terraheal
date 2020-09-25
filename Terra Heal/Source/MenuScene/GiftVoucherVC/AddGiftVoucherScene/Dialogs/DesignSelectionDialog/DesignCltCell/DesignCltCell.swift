//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class DesignCltCell: SelectionBorderCollectionCell {

    @IBOutlet weak var ivUser: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ivUser?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    func setData(data:Design) {
        super.setData(isSelected: data.isSelected)
        self.ivUser.downloadedFrom(link: data.image)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivUser?.layoutIfNeeded()
        self.ivUser?.setRound(withBorderColor: .themeHintText, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    
}




