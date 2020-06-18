//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum Currency: String {
    case Euro = "Euro"
    case Dollar = "Dollar"

    func name() -> String {
        switch self
        {
        case .Euro:
            return "Euro"
        case .Dollar:
            return "Dollar"
        }
    }
    func symbol() -> String {
        switch self
        {
        case .Euro:
            return "Euro"
        case .Dollar:
            return "Dollar"
        }
    }
}
class CustomCurrencyPicker: ThemeBottomDialogView {


    @IBOutlet weak var lblTitle: ThemeLabel!

    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var vwMainSelection: UIView!
    @IBOutlet weak var vwDollar: UIView!
    @IBOutlet weak var btnDollar: UIButton!
    @IBOutlet weak var lblDollar: ThemeLabel!
    @IBOutlet weak var ivDollarSelected: UIImageView!

    @IBOutlet weak var vwEuro: UIView!
    @IBOutlet weak var btnEuro: UIButton!
    @IBOutlet weak var lblEuro: ThemeLabel!
    @IBOutlet weak var ivEuroSelected: UIImageView!


    var onBtnDoneTapped: ((_ currency:Currency) -> Void)? = nil
    var selectedCurrency:Currency = Currency.Euro



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


        self.select(currency: self.selectedCurrency)
    }

    func select(currency:Currency) {
        self.selectedCurrency = currency

        btnDollar.setRound(withBorderColor: (currency == Currency.Dollar) ? UIColor.themePrimary : UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.5)
        ivDollarSelected.isHidden = (currency == Currency.Dollar) ? false : true
        ivEuroSelected.isHidden = (currency == Currency.Dollar) ? true : false
        btnEuro.setRound(withBorderColor: (currency == Currency.Dollar) ? UIColor.clear : UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.5)
        btnEuro?.setShadow()
        btnDollar?.setShadow()
        ivDollarSelected?.setRound()
        ivEuroSelected?.setRound()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))

        self.lblDollar.text = Currency.Dollar.name()
        self.lblDollar.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblEuro.text = Currency.Euro.name()
        self.lblEuro.setFont(name: FontName.Bold, size: FontSize.label_18)

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
        btnEuro?.setShadow()
        btnDollar?.setShadow()
        ivDollarSelected?.setRound()
        ivEuroSelected?.setRound()
        vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
    }




    @IBAction func btnDollarTapped(_ sender: Any) {
        self.select(currency: Currency.Dollar)
    }
    @IBAction func btnEuroTapped(_ sender: Any) {
        self.select(currency: Currency.Euro)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {

            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedCurrency);
            }

    }


}

