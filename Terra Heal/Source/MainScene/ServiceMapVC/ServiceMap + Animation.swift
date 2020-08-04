//
//  ServiceMap + Animation.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 23/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit
//MARK:   - Interative Animation
extension  ServiceMapVC {
    
    private func directionFromVelocity(_ velocity: CGPoint) -> AnimationDirection {
        guard velocity != .zero else { return .undefined }
        let isVertical = abs(velocity.y) > abs(velocity.x)
        var derivedDirection: AnimationDirection = .undefined
        if isVertical {
            derivedDirection = velocity.y < 0 ? .up: .down
        }
        else {
            derivedDirection = velocity.x < 0 ? .left: .right
        }
        return derivedDirection
    }
    
    func addCollapseAnimationPanGesture(view: UIView) {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:))) // will be defined later!
        view.addGestureRecognizer(recognizer)
    }
    
    func addExpandAnimationPanGesture(view: UIView) {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:))) // will be defined later!
        view.addGestureRecognizer(recognizer)
    }
    
    
    
    
    @objc func viewPanned(recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: vwService)
        let translate: CGPoint = recognizer.translation(in: vwService)
        let direction:AnimationDirection =  directionFromVelocity(velocity)
        
        switch recognizer.state {
        case .began:
            
            if transitionAnimator?.isRunning ?? true {
                transitionAnimator?.stopAnimation(true)
            }
            animationProgress = transitionAnimator?.fractionComplete ??  0
            self.upDownAnimation(direction: direction)
            transitionAnimator?.pauseAnimation()
            yPostion = translate.y
        case .changed:
            let totalYSwipe: CGFloat = translate.y - yPostion
            let height: CGFloat = UIScreen.main.bounds.height
            let percentage = CGFloat(abs(Float(totalYSwipe))) / height
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress
        case .ended, .failed , .cancelled:
            _ = transitionAnimator!.fractionComplete
            if direction == .up {
                transitionAnimator?.stopAnimation(true)
                self.upDownAnimation(direction: AnimationDirection.up)
                transitionAnimator?.startAnimation()
            } else {
                transitionAnimator?.stopAnimation(true)
                self.upDownAnimation(direction: AnimationDirection.down)
                transitionAnimator?.startAnimation()
            }
        default:
            break
        }
    }
    
    func upDownAnimation(direction:AnimationDirection) {
        switch  direction {
        case .up:
            self.doStepUpAnimation()
        case .down:
            self.doStepDownAnimation()
        case .left:
            print("No Animation Leftt")
        case .right:
            print("No Animation Right")
        default:
            print("No Animation")
        }
    }
    
    func doStepDownAnimation() {
        self.downDialogAnimation()
    }
    
    func setInitialAnimationProperty() {

        if let visibleCell = self.collectionView.visibleCells.first as? ServiceCell {
                    self.animatingCell = visibleCell
                    self.animatingCell.lblNameRect = self.animatingCell.lblName.frame
                    self.animatingCell.lblAddressRect = self.animatingCell.lblAddress.frame
                    self.animatingCell.ivMapRect = self.animatingCell.ivMap.frame
                    self.animatingCell.btnHoursRect = self.animatingCell.btnHours.frame
                    self.animatingCell.stkNumberOfServiceRect = self.animatingCell.stkNumberOfService.frame
                    self.animatingCell.lblServicesRect = self.animatingCell.lblServices.frame
        }
        if let visibleCell = self.cltForCollapseView.visibleCells.first as? ServiceCollapseCell {
                    self.targetAnimatingCell = visibleCell
        }
    }
    
    func downDialogAnimation() {
        print("DownAnimation")
        self.setInitialAnimationProperty()
        self.transitionAnimator?.stopAnimation(true)
        self.transitionAnimator?.addAnimations {
            self.animatingCell.lblName.frame = self.targetAnimatingCell.lblName.frame
            self.animatingCell.stkNumberOfService.frame = self.targetAnimatingCell.stkNumberOfService.frame
            //self.animatingCell.lblAddress.frame = self.targetAnimatingCell.lblAddress.frame
           // self.animatingCell.btnHours.frame = self.targetAnimatingCell.btnHours.frame
           // self.animatingCell.ivMap.frame = self.targetAnimatingCell.ivMap.frame
            self.ivService.alpha = 0.0
            self.vwService.transform = CGAffineTransform(translationX:0, y: self.vwServiceDialog.frame.height  - self.vwForCollapseView.frame.height)
            self.vwBottomButtons.alpha = 0.5
            self.animatingCell.vwExpandedView.layoutIfNeeded()
        }
        self.transitionAnimator?.addCompletion({ (position) in
            self.vwService.isHidden = true
            self.vwForCollapseView.isHidden = false
            self.vwBottomButtons.isHidden = true
            self.mapView.padding = UIEdgeInsets.init(top: 20, left: 20, bottom: self.vwForCollapseView.frame.height, right: 20)
        })
        
        
    }
    func doStepUpAnimation() {
        self.upDialogAnimation()
    }
    
    func upDialogAnimation() {
        if animatingCell == nil {
            return;
        }
        self.vwForCollapseView.isHidden = true
        self.vwService.isHidden = false
        self.vwBottomButtons.isHidden = false
        self.ivService.alpha = 0.0
        transitionAnimator?.stopAnimation(true)
        transitionAnimator?.addAnimations {
            self.animatingCell.lblName.frame = self.animatingCell.lblNameRect
            self.animatingCell.stkNumberOfService.frame = self.animatingCell.stkNumberOfServiceRect
            //self.animatingCell.lblAddress.frame = self.animatingCell.lblAddressRect
            //self.animatingCell.ivMap.frame =  self.animatingCell.ivMapRect
            //self.animatingCell.btnHours.frame = self.animatingCell.btnHoursRect
            self.ivService.alpha = 1.0
            self.vwBottomButtons.alpha = 1.0
            self.vwService.transform = CGAffineTransform.identity
            self.animatingCell.vwExpandedView.layoutIfNeeded()
        }
        transitionAnimator?.addCompletion({ (position) in
            self.collectionView.reloadData {
                    self.vwService.isUserInteractionEnabled = true
                    self.mapView.padding = UIEdgeInsets.init(top: 20, left: 20, bottom: self.vwService.frame.height, right: 20)
            }
        })
    }
}
