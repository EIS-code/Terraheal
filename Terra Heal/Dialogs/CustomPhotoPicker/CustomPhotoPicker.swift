//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomPhotoPicker: ThemeBottomDialogView {


    @IBOutlet weak var lblTitle: ThemeLabel!

    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblCamera: ThemeLabel!

    @IBOutlet weak var vwGallary: UIView!
    @IBOutlet weak var btnGallary: UIButton!
    @IBOutlet weak var lblGallary: ThemeLabel!

    var onBtnCameraTapped: (() -> Void)? = nil
    var onBtnGallaryTapped: (() -> Void)? = nil
    var onBtnDoneTapped: (() -> Void)? = nil
    //Animation Properties
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
    }



    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))

        self.lblCamera.text = "Camera"
        self.lblCamera.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblGallary.text = "Gallary"
        self.lblGallary.setFont(name: FontName.Bold, size: FontSize.label_18)

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
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        if self.onBtnCameraTapped != nil {
            self.onBtnCameraTapped!();
        }
    }

    @IBAction func btnGallaryTapped(_ sender: Any) {
        if self.onBtnGallaryTapped != nil {
            self.onBtnGallaryTapped!();
        }
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }




}

