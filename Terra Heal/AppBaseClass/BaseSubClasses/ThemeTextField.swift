//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
class ThemeTextField: UITextField {

    override func draw(_ rect: CGRect) {
    }
    
    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.font = FontHelper.font(name: name, size: finalSize)
    }
}
