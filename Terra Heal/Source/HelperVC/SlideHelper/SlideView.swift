//
//  SlideView.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 17/08/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit




class SlideTouchVw: ThemeView {
    
    weak var slideLeftVC: SlideVC?
    weak var slideRightVC: SlideVC?
    var allowSide: Bool = false
    weak var currentSlideVC: SlideVC?
    // MARK: LifeCycle
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let vw: UIView = super.hitTest(point, with: event) ?? UIView()
        
        let width: CGFloat = Common.screenRect.size.width
        let conditionForLeftView: Bool = (point.x < 20)
        let conditionForRightView: Bool = (point.x > width - 20)
        if conditionForRightView || conditionForLeftView {
            if conditionForLeftView {
                if let leftVC: SlideVC = self.slideLeftVC {
                    self.currentSlideVC = leftVC
                }
            } else {
                if let rightVC: SlideVC = self.slideRightVC {
                    self.currentSlideVC = rightVC
                }
            }
            if self.currentSlideVC != nil {
                if self.currentSlideVC!.isOpen {
                    self.allowSide = true
                    if vw.isKind(of: UITableView.self) {
                        return self
                    }
                    else if vw.isKind(of: UICollectionView.self) {
                        return self
                    }
                    else {
                        if self.currentSlideVC!.view.frame.contains(point) {
                            print(self.currentSlideVC!)
                            return vw
                        }
                        else {
                            return self
                        }
                    }
                }
                else {
                    
                }
            }
        }
        return vw
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first {
            let point: CGPoint = touch.location(in: self)
            SO.startX = Int(point.x)
            SO.X = Int(point.x)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first {
            let pointPrevious: CGPoint = touch.previousLocation(in: self)
            let point: CGPoint = touch.location(in: self)
            SO.X = 0//Int(point.x)
            let timeInterval: TimeInterval = Date.timeIntervalSinceReferenceDate-SO.timeInterval
            let xMove: CGFloat = point.x-pointPrevious.x
            let yMove: CGFloat = point.y-pointPrevious.y
            let distance: CGFloat = sqrt((xMove*xMove)+(yMove*yMove))
            SO.speed = Int(distance/CGFloat(timeInterval))
            SO.timeInterval = Date.timeIntervalSinceReferenceDate
            if self.allowSide {
               self.currentSlideVC?.show(withPoint: point)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if let touch = touches.first  {
            if self.allowSide {
                let point: CGPoint = touch.location(in: self)
                let difference: Int = SO.startX-SO.X
                if difference < 0 {
                    let sideVC: SlideVC = self.slideLeftVC!
                    let width: CGFloat = (sideVC.view?.frame.size.width ?? 0.0)/3.0
                    if sideVC.isOpen {
                        if (SO.speed >= SO.maxSpeed && difference > 0) ||
                            (point.x <= width && difference > 0) {
                            sideVC.hide()
                        }
                        else {
                            self.sideVCTblVwContains(point)
                        }
                    }
                    else {
                        if (SO.speed >= SO.maxSpeed) ||
                            (point.x >= width) {
                            sideVC.show()
                        }
                        else {
                            sideVC.hide()
                        }
                    }
                } else {
                    let sideVC: SlideVC = self.slideRightVC!
                    let width: CGFloat = (sideVC.view?.frame.size.width ?? 0.0)/3.0
                    if sideVC.isOpen {
                        if (SO.speed >= SO.maxSpeed && difference < 0) ||
                            (point.x > width && difference < 0) {
                            sideVC.hide()
                        }
                        else {
                            self.sideVCTblVwContains(point)
                        }
                    }
                    else {
                        if (SO.speed >= SO.maxSpeed) ||
                            (point.x > width) {
                            sideVC.show()
                        }
                        else {
                            sideVC.hide()
                        }
                    }
                }
                
                
            }
        }
    }
    
    func sideVCTblVwContains(_ point: CGPoint) {
        if let sideVC = self.currentSlideVC {
            if sideVC.view.frame.contains(point) {
                sideVC.show()
            }
            else {
                sideVC.hide()
            }
        }
    }
    
}

typealias SO = SlideProperties

class SlideProperties: NSObject {
    
    static var vwBg: UIView = UIView()
    static let maxAlphaVwBg: CGFloat = 1.0
    static let animateDuration: TimeInterval = 0.3
    static var timeInterval: TimeInterval = 0.0
    static var speed: Int = 0
    static let maxSpeed: Int = 1555
    static var startX: Int = 0
    static var X: Int = 0
    
    
    class func addVwBgToVw(_ vw: UIView) {
        SO.vwBg.frame = vw.bounds
        SO.vwBg.backgroundColor = UIColor(white: 0.0, alpha: 1.0)
        SO.vwBg.alpha = 0.0
        vw.addSubview(SO.vwBg)
    }
    
    class func removeVwBg() {
        SO.vwBg.alpha = 0.0
        SO.vwBg.removeFromSuperview()
    }
    
}
