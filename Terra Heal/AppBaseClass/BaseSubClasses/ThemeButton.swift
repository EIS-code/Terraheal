//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

class ThemeButton: UIButton {


    var isButtonHighlighted: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }




    func setUpRoundedButton() {
        self.setImage(nil, for: .normal)
        self.setTitle(FontSymbol.next_arrow, for: .normal)
        self.setFont(name: FontName.System, size: 45)
        self.height(constant: JDDeviceHelper().offseter(offset: 60))
        self.setRound(withBorderColor: .clear, andCornerRadious: 0.0, borderWidth: 1.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 20.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }

    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.titleLabel?.font = FontHelper.font(name: name, size: finalSize)
    }

    func setHighlighted(isHighlighted: Bool) {
        self.isButtonHighlighted = isHighlighted
        self.isSelected = isHighlighted
        if isHighlighted {
            self.backgroundColor = UIColor.themePrimary
            self.setTitleColor(UIColor.themeLightTextColor, for: .normal)
            self.setRound(withBorderColor: UIColor.clear, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
        } else {
            self.backgroundColor = UIColor.themeLightTextColor
            self.setTitleColor(UIColor.themePrimary, for: .normal)
            self.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
        }

    }

    func setHomeSelected(isSelected: Bool) {
        self.isButtonHighlighted = isSelected
        self.isSelected = isSelected
        if isSelected {
            self.backgroundColor = UIColor.themePrimary
            self.setTitleColor(UIColor.themeLightTextColor, for: .normal)
            self.setRound(withBorderColor: UIColor.clear, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
        } else {
            self.backgroundColor = UIColor.themeLightTextColor
            self.setTitleColor(UIColor.themePrimary, for: .normal)
            //self.setRound(withBorderColor: UIColor.themePrimary, andCornerRadious: self.frame.height/2.0, borderWidth: 1.0)
        }

    }
}


//MARK: FloatingRound Button
class FloatingRoundButton: ThemeButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpFloatingButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpFloatingButton()
    }

    func setUpFloatingButton() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.0
    }
    func setForwardButton() {
        self.height(constant: JDDeviceHelper().offseter(offset: 60))
        self.setFont(name: FontName.System, size: 45)
        self.setTitle(FontSymbol.next_arrow, for: .normal)
    }
    func setBackButton() {
        self.height(constant: JDDeviceHelper().offseter(offset: 50))
        self.setFont(name: FontName.System, size: 37)
        self.setTitle(FontSymbol.back_arrow, for: .normal)
    }

}


//MARK: FloatingRoundRadius Button
class FloatingRoundRadiusButton: ThemeButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpFloatingButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpFloatingButton()
    }

    func setUpFloatingButton() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height/2.0
    }
    func setForwardButton() {
        self.height(constant: JDDeviceHelper().offseter(offset: 60))
        self.setFont(name: FontName.System, size: 45)
        self.setTitle(FontSymbol.next_arrow, for: .normal)
    }
    func setBackButton() {
        self.height(constant: JDDeviceHelper().offseter(offset: 50))
        self.setFont(name: FontName.System, size: 37)
        self.setTitle(FontSymbol.back_arrow, for: .normal)
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


