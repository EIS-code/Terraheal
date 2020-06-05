//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit
import FSCalendar

class CustomDatePicker: ThemeDialogView {

     @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblSelectedYear: ThemeLabel!
    @IBOutlet weak var lblSelectedDate: ThemeLabel!

    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!

    @IBOutlet weak var btnPrevious: ThemeButton!
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnCancel: UnderlineTextButton!

    @IBOutlet weak var vwTopBar: UIView!

    @IBOutlet weak var vwMainCalender: UIView!
    var onBtnDoneTapped: ((_ date:Double) -> Void)? = nil
    var onBtnCancelTapped: (() -> Void)? = nil

    var selectedMilli:Double = 0

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)


    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0

    func initialize(title:String, buttonTitle:String, cancelButtonTitle:String) {

        self.initialSetup()

        self.lblTitle.text = title
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }






    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))

        self.btnPrevious.setTitle(FontSymbol.back_arrow, for: .normal)
        self.btnPrevious.setFont(name: FontName.SemiBold, size: FontSize.button_22)

        self.btnNext.setTitle(FontSymbol.next_arrow, for: .normal)
        self.btnNext.setFont(name: FontName.SemiBold, size: FontSize.button_22)

        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnDone.setHighlighted(isHighlighted: true)

        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)

        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.addPanGesture(view: dialogView)
        self.setupCalendarView(calendar: vwCalendar)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //vwMainCalender?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
        vwMainCalender?.setShadow()
        vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
    }


    func show(animated:Bool){

        self.selectDate(date: Date())
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


    @IBAction func btnPreviousTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.previousMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.nextMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedMilli == 0 {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATE".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedMilli);
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
extension  CustomDatePicker {

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


extension CustomDatePicker: FSCalendarDataSource, FSCalendarDelegate {

    func setupCalendarView(calendar: FSCalendar) {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: FontSize.button_14)
        calendar.appearance.weekdayTextColor = UIColor.lightGray
        calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.SemiBold, size: FontSize.button_18)
        calendar.appearance.headerTitleColor = UIColor.darkGray
        

    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")

        self.selectDate(date: date)
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func selectDate(date:Date) {
        self.lblSelectedDate.text = date.toString(format: "EEE, MMM dd")
        self.lblSelectedYear.text = date.toString(format: "yyyy")
        self.vwCalendar.select(date)
        self.selectedMilli = date.millisecondsSince1970
    }
}
