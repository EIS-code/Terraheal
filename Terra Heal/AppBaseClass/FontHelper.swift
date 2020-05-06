//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

struct FontName {
    static let GradDuke: String = "GRAND DUKE"
    static let Ovo: String = "Ovo"
}

struct FontSize {

    static let nav_title_18: CGFloat = 18
    static let textField_14: CGFloat = 14
    static let textField_20: CGFloat = 20
    static let placeHolder_14: CGFloat = 12


    static let button_18: CGFloat = 18
    static let button_22: CGFloat = 22
    static let button_20: CGFloat = 20
    static let button_14: CGFloat = 14

    static let label_14: CGFloat = 12
    static let label_20: CGFloat = 20
    static let label_18: CGFloat = 18
    static let label_26: CGFloat = 26
    static let label_36: CGFloat = 36


}

class FontHelper:UIFont
{
    class func font(name: String, size: CGFloat, referenceScreenSize:CGFloat =  375) -> UIFont {
        return UIFont(name: name , size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

struct ReferenceScreenSize {
    
}
