//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation



class FocusAreaCltCell: SelectionBorderCollectionCell {
    
    var data: PreferenceOption!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var ivFocusArea: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName.setFont(name: FontName.SemiBold, size: FontSize.large)
    }
    
    func setData(data:PreferenceOption) {
        self.data = data
        self.lblName.text = data.name
        self.ivFocusArea.downloadedFrom(link: data.icon)
        super.setData(isSelected: data.isSelected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
 
}

