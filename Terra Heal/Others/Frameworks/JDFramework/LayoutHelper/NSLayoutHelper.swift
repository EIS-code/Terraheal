//  NSLayoutHelper.swift
//  Layout Helper
//
//  Created by Kuldeep Tanwar on 4/15/19.
//  Copyright © 2019 Kuldeep Tanwar. All rights reserved.
import UIKit
@IBDesignable class NSLayoutHelper : NSLayoutConstraint {
   
   
    @IBInspectable var iPhone11Pro: CGFloat = 0.0 {
        didSet { deviceConstant(value:iPhone11Pro) }
    }
    open func deviceConstant(value:CGFloat) {
        constant = JDDeviceHelper.offseter(scaleFactor: 1.0, offset: value, direction: .vertical)
        print("\(value) and new constant \(constant)")
    }
}

