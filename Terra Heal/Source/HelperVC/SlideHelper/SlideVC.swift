//
//  SlideVC.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 17/08/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

class SlideVC: MainVC {
    var isOpen: Bool = false
    var direction: AnimationDirection = .left
    class func addLeftToVC(_ vC: UIViewController, sideVC: SlideVC) {
        SO.timeInterval = Date.timeIntervalSinceReferenceDate
        SO.speed = 0
        SO.startX = 0
        SO.X = 0
        SlideVC.vwFrameForLeftView(vC.view.frame, slideVC: sideVC)
        //SO.addVwBgToVw(vC.view)
        sideVC.direction = .left
        if vC.view.isKind(of: SlideTouchVw.self) {
            let sTouchVw: SlideTouchVw = vC.view as! SlideTouchVw
            sTouchVw.slideLeftVC = sideVC
            sTouchVw.allowSide = true
        }
        vC.addChild(sideVC)
        vC.view.addSubview(sideVC.view)
    }
    
    class func addRightToVC(_ vC: UIViewController, sideVC: SlideVC) {
        SO.timeInterval = Date.timeIntervalSinceReferenceDate
        SO.speed = 0
        SO.startX = Int(Common.screenRect.maxX)
        SO.X = 0
        sideVC.direction = .right
        SlideVC.vwFrameForRightView(vC.view.frame, slideVC: sideVC)
       // SO.addVwBgToVw(vC.view)
        if vC.view.isKind(of: SlideTouchVw.self) {
            let sTouchVw: SlideTouchVw = vC.view as! SlideTouchVw
            sTouchVw.slideRightVC = sideVC
            sTouchVw.allowSide = true
        }
        vC.addChild(sideVC)
        vC.view.addSubview(sideVC.view)
    }
    
    class func remove() {
        /*let sideVC: SideVC = SideVC.shared
        sideVC.hide()
        //SO.removeVwBg()
        sideVC.view.removeFromSuperview()
        sideVC.removeFromParent()
        let profileVC: ProfileVC = ProfileVC.shared
        profileVC.hide()
        //SO.removeVwBg()
        profileVC.view.removeFromSuperview()
        profileVC.removeFromParent()*/
        
    }
    
    
    class func vwFrameForRightView(_ frame: CGRect, slideVC: SlideVC) {
        var rect: CGRect = frame
        rect.origin.x = frame.size.width
        rect.origin.x *=  1.0
        slideVC.view.frame = rect
    }
    
    class func vwFrameForLeftView(_ frame: CGRect, slideVC: SlideVC) {
           var rect: CGRect = frame
           rect.origin.x -= frame.size.width
           rect.origin.x *=  1.0
           slideVC.view.frame = rect
    }
    
    
    func show() {
        self.isOpen = true
        UIView.animate(withDuration: SO.animateDuration,
                       animations: {
                        self.view.frame.origin.x = 0
                        SO.vwBg.alpha = SO.maxAlphaVwBg
        }) { (bl: Bool) in
        }
    }
    
    func show(withPoint point: CGPoint) {
        let screenWidth: CGFloat = Common.screenRect.size.width
        let diff: CGFloat = screenWidth-self.view.frame.size.width
        let difference: Int = SO.startX-SO.X
        var rect: CGRect = self.view.frame
        if self.direction == .left {
            if point.x <= screenWidth {
                    let originX: CGFloat = point.x-screenWidth+diff
                    rect.origin.x = originX > 0.0 ? 0.0 : originX
                    if self.isOpen {
                        rect.origin.x = (difference > 0) ? CGFloat(-difference) : 0.0
                    }
                    self.view.frame = rect
                    if !(self.isOpen && (difference <= 0)) {
                        let alpha: CGFloat = (point.x*SO.maxAlphaVwBg)/(screenWidth-diff)
                        SO.vwBg.alpha = alpha > SO.maxAlphaVwBg ? SO.maxAlphaVwBg : alpha
                    }
            }
        } else {
            if point.x <= screenWidth {
                    let originX: CGFloat = point.x //diff
                rect.origin.x = originX > 0.0 ?  originX : 0.0
                    if self.isOpen {
                        rect.origin.x = (difference > 0) ? CGFloat(-difference) : 0.0
                    }
                    self.view.frame = rect
                    if !(self.isOpen && (difference <= 0)) {
                        let alpha: CGFloat = (point.x*SO.maxAlphaVwBg)/(screenWidth-diff)
                        SO.vwBg.alpha = alpha > SO.maxAlphaVwBg ? SO.maxAlphaVwBg : alpha
                    }
            }
        }
        
        
    }
    
    func hide(_ completion: (() -> Void)? = nil) {
        self.isOpen = false
        
        var x: CGFloat = Common.screenRect.size.width
        if self.direction == .left {
            x *=  -1.0
        } else {
            x *=  1.0
        }
        UIView.animate(withDuration: SO.animateDuration,
                       animations: {
                        self.view.frame.origin.x = x
                        SO.vwBg.alpha = 0.0
        }) { (bl: Bool) in
            if bl {
                completion?()
            }
        }
    }
}
