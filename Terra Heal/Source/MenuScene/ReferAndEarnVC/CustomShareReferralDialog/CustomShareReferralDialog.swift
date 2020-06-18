//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

struct ShareReferral {
    var referralHeader: String = "hello,\nVirendra has\nrecommended\nyou to terra heal"
    var description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis"
    var image: UIImage = UIImage()
}
class CustomShareReferralDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!

    var onBtnDoneTapped: ((_ data: ShareReferral ) -> Void)? = nil
    var shareReferral: ShareReferral = ShareReferral()

    func initialize(title:String, data:ShareReferral = ShareReferral(), buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.lblHeader.text = data.referralHeader
        self.lblDescription.text = data.description
        self.btnDone.setTitle(buttonTitle, for: .normal)

        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear

        self.lblHeader.setFont(name: FontName.SemiBold, size: FontSize.label_22)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.addPanGesture(view: self)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)
        self.btnDone.setHighlighted(isHighlighted: true)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.layoutIfNeeded()
        self.btnDone?.setHighlighted(isHighlighted: true)
        self.scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(shareReferral);
            }
    }

}


