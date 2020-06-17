//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
open class ThemeTextField: UITextField {


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
    func setPlaceholderFont(name:String,size:CGFloat) {

        self.placeholderLabel.setFont(name: FontName.Regular, size: FontSize.label_22)
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

//MARK: Prevent from infinity calls
private var __maxLengths = [UITextField: Int]()
extension ThemeTextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 20 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text  {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
