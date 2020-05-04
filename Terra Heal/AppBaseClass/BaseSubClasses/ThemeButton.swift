//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeButton: UIButton {
    
    override func draw(_ rect: CGRect) {
    }

    func setUpRoundedButton() {
        self.setRound(withBorderColor: .clear, andCornerRadious: 0.0, borderWidth: 1.0)
    }

    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.titleLabel?.font = FontHelper.font(name: name, size: finalSize)
    }
}


//MARK: Underlined Button
class UnderlineTextButton: ThemeButton {

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: .normal)
        self.setAttributedTitle(self.attributedString(), for: .normal)
    }

    private func attributedString() -> NSAttributedString? {
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : self.titleLabel?.font ?? UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : self.titleColor(for: .normal) ?? UIColor.red,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: self.currentTitle!, attributes: attributes)
        return attributedString
    }
}
