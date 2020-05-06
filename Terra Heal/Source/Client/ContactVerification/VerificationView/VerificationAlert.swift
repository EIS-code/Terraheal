//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class VerificationAlert: ThemeDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var lblMessageDetail: ThemeLabel!
    @IBOutlet weak var btnVerify: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var dialogView: UIView!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet weak var animationVw: UIView!
    @IBOutlet weak var btnResend: UnderlineTextButton!

    var verificationData: String = ""

    var onBtnCancelTapped : (() -> Void)? = nil
    var onBtnDoneTapped : ((_ code:String) -> Void)? = nil

    var code:String = ""
    func initialize(message:String, data:String) {

        self.lblTitle.text = "VERIFICATION_LBL_TITLE".localized()
        self.lblMessage.text = message
        self.lblMessageDetail.text = "VERIFICATION_MSG_DETAIL".localized() + " " + data
        self.verificationData = data
        self.btnVerify.setTitle("VERIFICATION_BTN_VERIFY".localized(), for: .normal)
        self.btnResend.setTitle("VERIFICATION_BTN_RESEND".localized(), for: .normal)
        self.initialSetup()

    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.lblMessage.setFont(name: FontName.GradDuke, size: FontSize.button_22)
        self.lblMessageDetail.setFont(name: FontName.Ovo, size: FontSize.label_14)
        self.setupOtpView()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.setUpRoundedButton()
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
            self.animationVw.alpha = 0.5
            self.animationVw.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
            UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut], animations: {
                self.animationVw.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.animationVw.alpha = 1.0
            }) { (completion) in
                // self.animationVw.shake()
                self.isUserInteractionEnabled = true
            }
        }
        else {
            self.backgroundView.alpha = 0.66
        }

    }

    func dismiss(){
        if self.isAnimated {
            self.animationVw.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.animationVw.alpha = 1.0
            UIView.animate(withDuration: 0.35, delay: 0.0, options: [.curveEaseOut], animations: {
                self.animationVw.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
                self.backgroundView.alpha = 0.0
                self.animationVw.alpha = 0.5
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

    @IBAction func btnCalcelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {

        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(code);
        }
    }

}
//OTP  Setup
extension VerificationAlert:  OTPFieldViewDelegate {

    func setupOtpView(){
        self.otpTextFieldView.fieldsCount = 4
        self.otpTextFieldView.fieldBorderWidth = 1
        self.otpTextFieldView.defaultBorderColor = UIColor.themePrimaryBorder
        self.otpTextFieldView.filledBorderColor = UIColor.themePrimary
        self.otpTextFieldView.cursorColor = UIColor.themePrimary
        self.otpTextFieldView.displayType = .square
        self.otpTextFieldView.fieldSize = 60
        self.otpTextFieldView.separatorSpace = 0
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
    }
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }

    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }

    func enteredOTP(otp otpString: String) {
        self.code = otpString
        print("OTPString: \(otpString)")
    }
}
