//
//  ThemeBottomDialog.swift
//  Terra Heal
//
//  Created by Jaydeep on 09/06/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

class ThemeDialogView: ThemeView {
    var isCancellable:Bool = false
    var isAnimated:Bool = false
    deinit {
        print("\(self) \(#function)")
    }
}


class ThemeBottomDialogView: ThemeView {
    @IBOutlet weak var btnCancel: UnderlineTextButton!
    @IBOutlet weak var vwTopBar: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogView: UIView!

    var onBtnCancelTapped: (() -> Void)? = nil

    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0

    var isCancellable:Bool = false
    var isAnimated:Bool = false
    deinit {
        print("\(self) \(#function)")
    }


    @IBAction func btnCancelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }


    
}

//MARK:   - Interative Animation
extension  ThemeBottomDialogView {


    func show(animated:Bool){
        
        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        if let topController = Common.appDelegate.getTopViewController() {
            topController.view.endEditing(true)
            topController.view.addSubview(self)
        }

        if animated {
            self.isUserInteractionEnabled = false
            self.dialogView.alpha = 0.1
            self.dialogView.transform = CGAffineTransform(translationX: 0.0, y: self.frame.maxY)
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
                self.dialogView.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.dialogView.alpha = 1.0
            }) { (completion) in
                //self.animationVw.shake()
                self.isUserInteractionEnabled = true
            }
        }
        else {
            self.backgroundView.alpha = 0.66
        }

    }

    func dismiss(){
        if self.isAnimated {
            self.dialogView.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.dialogView.alpha = 1.0
            UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut], animations: {

                self.dialogView.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.dialogView.alpha = 0.1

            }) { (completion) in
                self.removeFromSuperview()
            }
        }else{
            self.removeFromSuperview()
        }

    }


    @objc func didTappedOnBackgroundView(){
        if isCancellable {
            dismiss()
        }
    }


    func addPanGesture(view: UIView) {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(viewPanned(recognizer:))) // will be defined later!
        view.addGestureRecognizer(recognizer)
    }

    func dismissWithInteractiveAnimation() {

    }

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


    @objc func viewPanned(recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: self)
        let translate: CGPoint = recognizer.translation(in: self)
        let direction:AnimationDirection =  directionFromVelocity(velocity)

        switch recognizer.state {
        case .began:

            if transitionAnimator?.isRunning ?? true {
                transitionAnimator?.stopAnimation(true)
            }
            animationProgress = transitionAnimator?.fractionComplete ??  0
            self.addDissmissAnimation(direction: direction)
            transitionAnimator?.pauseAnimation()
            yPostion = translate.y
        case .changed:
            let totalYSwipe: CGFloat = translate.y - yPostion
            let height: CGFloat = UIScreen.main.bounds.height
            let percentage = CGFloat(abs(Float(totalYSwipe))) / height
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress

        case .ended, .failed , .cancelled:
            let fractionComplete = transitionAnimator!.fractionComplete
            if direction == .up {
                 transitionAnimator?.stopAnimation(true)
                 self.addDissmissAnimation(direction: AnimationDirection.up)
                transitionAnimator?.startAnimation()
            } else {
                transitionAnimator?.stopAnimation(true)
                if fractionComplete < 0.1 {
                    self.addDissmissAnimation(direction: AnimationDirection.up)
                } else {
                    self.addDissmissAnimation(direction: AnimationDirection.down)
                }
                transitionAnimator?.startAnimation()
            }

        default:
            break
        }
    }
    func addDissmissAnimation(direction:AnimationDirection) {


        switch  direction {
        case .up:
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                self.dialogView.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.dialogView.alpha = 1.0
            }
            transitionAnimator?.addCompletion({ (position) in
                self.isUserInteractionEnabled = true
            })

        case .down:
            transitionAnimator?.stopAnimation(true)
            transitionAnimator?.addAnimations {
                self.dialogView.transform = CGAffineTransform(translationX:0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.dialogView.alpha = 0.1
            }
            transitionAnimator?.addCompletion({ (position) in
                self.removeFromSuperview()
                if self.onBtnCancelTapped != nil {
                    self.onBtnCancelTapped!();
                }
            })
        case .left,.right:
            print("No Animation")
        default:
            print("No Animation")

        }



    }


}


