//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class TimeDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var btnDone: FloatingRoundButton!
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnNext: ThemeButton!
    var onBtnDoneTapped : ((_ time: Double) -> Void)? = nil
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.btnNext.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }
    
    func initialSetup() {
        self.backgroundColor = .clear
        dialogView.clipsToBounds = true
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        
        self.timePicker.backgroundColor = UIColor.clear
        self.timePicker.setValue(UIColor.themePrimary, forKeyPath: "textColor")
      
       self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.addPanGesture(view: self)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.btnDone.setForwardButton()
        self.btnNext.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func onClickBtnDone(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(self.timePicker.date.millisecondsSince1970 - Calendar.current.startOfDay(for: timePicker.date).millisecondsSince1970);
        }
    }
    
    @IBAction func btnCalcelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }
    
}


