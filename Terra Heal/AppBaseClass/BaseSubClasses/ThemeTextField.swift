//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
open class ThemeTextField: UITextField {

    override open func draw(_ rect: CGRect) {
    }
    
    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.font = FontHelper.font(name: name, size: finalSize)
    }
}


class ThemeTextView: UITextView {

    let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)


    func setFont(name:String,size:CGFloat){
        let finalSize = JDDeviceHelper().fontCalculator(size: size)
        self.font = FontHelper.font(name: name, size: finalSize)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setRound(withBorderColor: .themePrimary, andCornerRadious: 25.0, borderWidth: 1.0)
        textContainerInset = padding
    }




}


extension UITextView {


    private class PlaceholderLabel: ThemeLabel { }

    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.setFont(name: FontName.Regular, size: FontSize.label_22)
            label.textColor = UIColor.themePrimary
            addSubview(label)
            return label
        }
    }

    @IBInspectable
    var placeholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.numberOfLines = 0
            let width = frame.width - 40
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: 20, y: textContainerInset.top)

            textStorage.delegate = self
        }
    }

}


extension UITextView: NSTextStorageDelegate{

    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
}
