//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomTextViewDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var txtDescription: ThemeTextView!
    var strEnteredData: String = ""
    var onBtnDoneTapped: ((_ data:String) -> Void)? = nil


    func initialize(title:String,data: String , buttonTitle:String,cancelButtonTitle:String) {
        self.lblTitle.text = title
        self.txtDescription.text = data
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        self.initialSetup()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.txtDescription.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.txtDescription.setPlaceholderFont(name: FontName.Regular, size: FontSize.label_14)
        self.txtDescription.placeholder = "Lorem ipsum dolor"
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.txtDescription?.delegate = self
        self.addPanGesture(view: self)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)
        self.btnDone.setHighlighted(isHighlighted: true)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.setHighlighted(isHighlighted: true)
    }



    @IBAction func btnDoneTapped(_ sender: Any) {
        strEnteredData = txtDescription.text?.trim() ?? ""
        if strEnteredData.isEmpty() {
            Common.showAlert(message: "VALIDATION_MSG_INVALID_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(strEnteredData);
            }
        }
    }

}

extension CustomTextViewDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

    }
}

