//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation


struct TutorialDetail {
    var title:String = ""
    var description:String = ""
    var image: String = "asset-tutorial-0"
}

class TutorialCell: CollectionCell {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var ivTutorial: FixedWidthAspectFitImageView!

    override func awakeFromNib()  {
        super.awakeFromNib()

    }

    func setData(tutorialDetail:TutorialDetail) {

        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblTitle?.text = tutorialDetail.title
        self.lblDescription?.text = tutorialDetail.description
        self.ivTutorial.image = UIImage.init(named: tutorialDetail.image)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}




