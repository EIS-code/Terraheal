//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomGenderPicker: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var vwMainGender: UIView!
    @IBOutlet weak var vwMale: UIView!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var lblMale: ThemeLabel!
    @IBOutlet weak var ivMaleSelected: UIImageView!

    @IBOutlet weak var vwFemale: UIView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var lblFemale: ThemeLabel!
    @IBOutlet weak var ivFemaleSelected: UIImageView!


    var onBtnDoneTapped: ((_ gender:Gender) -> Void)? = nil
    var selectedGender:Gender = Gender.Male



    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)


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

    func select(gender:Gender) {
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

    @IBAction func btnMaleTapped(_ sender: Any) {
        self.select(gender: Gender.Male)
    }
    @IBAction func btnFemaleTapped(_ sender: Any) {
        self.select(gender: Gender.Female)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedGender == Gender.Other {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedGender);
            }
        }

    }
}



