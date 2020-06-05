//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomGenderPicker: ThemeDialogView {

    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var lblTitle: ThemeLabel!

    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var btnCancel: UnderlineTextButton!
    @IBOutlet weak var vwTopBar: UIView!
    @IBOutlet weak var vwMainGender: UIView!
    @IBOutlet weak var vwMale: UIView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var lblMale: ThemeLabel!
    @IBOutlet weak var ivMaleSelected: UIImageView!

    @IBOutlet weak var vwFemale: UIView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var lblFemale: ThemeLabel!
    @IBOutlet weak var ivFemaleSelected: UIImageView!


    var onBtnDoneTapped: ((_ gender:String) -> Void)? = nil
    var onBtnCancelTapped: (() -> Void)? = nil
    var selectedGender:String = Gender.Male



    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)


    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0

    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()

        self.lblTitle.text = title
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }


        self.select(gender: self.selectedGender)
    }

    func select(gender:String) {
        self.selectedGender = gender

        btnMale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.themePrimary : UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.5)
        ivMaleSelected.isHidden = (gender == Gender.Male) ? false : true
        ivFemaleSelected.isHidden = (gender == Gender.Male) ? true : false
        btnFemale.setRound(withBorderColor: (gender == Gender.Male) ? UIColor.clear : UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.5)
        btnFemale?.setShadow()
        btnMale?.setShadow()
        ivMaleSelected?.setRound()
        ivFemaleSelected?.setRound()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))

        self.lblMale.text = "GENDER_MALE".localized()
        self.lblMale.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblFemale.text = "GENDER_FEMALE".localized()
        self.lblFemale.setFont(name: FontName.Bold, size: FontSize.label_18)





        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnDone.setHighlighted(isHighlighted: true)

        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)

        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)

        self.addPanGesture(view: dialogView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        btnFemale?.setShadow()
        btnMale?.setShadow()
        ivMaleSelected?.setRound()
        ivFemaleSelected?.setRound()
        vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
    }


    func show(animated:Bool){

        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        if let topController = Common.appDelegate.getTopViewController() {
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

    @IBAction func btnMaleTapped(_ sender: Any) {
        self.select(gender: Gender.Male)
    }
    @IBAction func btnFemaleTapped(_ sender: Any) {
        self.select(gender: Gender.Female)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedGender == Gender.Other {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATE".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedGender);
            }
        }

    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }

}


//MARK:   - Interative Animation
extension  CustomGenderPicker {

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
            let totalYSwipe: CGFloat = translate.x - yPostion
            let height: CGFloat = UIScreen.main.bounds.size.height
            let percentage = CGFloat(abs(Float(totalYSwipe))) / height
            animationProgress  = percentage
            transitionAnimator?.fractionComplete = animationProgress

        case .ended, .failed , .cancelled:
            transitionAnimator?.stopAnimation(true)
            self.addDissmissAnimation(direction: direction)
            transitionAnimator?.startAnimation()

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


