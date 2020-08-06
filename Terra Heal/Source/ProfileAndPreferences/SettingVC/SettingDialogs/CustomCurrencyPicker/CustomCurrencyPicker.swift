//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
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
    
    
    @IBOutlet weak var vwMainSelection: UIView!
    @IBOutlet weak var vwDollar: UIView!
    @IBOutlet weak var btnDollar: UIButton!
    @IBOutlet weak var lblDollar: ThemeLabel!
    @IBOutlet weak var ivDollarSelected: PaddedImageView!
    
    @IBOutlet weak var vwEuro: UIView!
    @IBOutlet weak var btnEuro: UIButton!
    @IBOutlet weak var lblEuro: ThemeLabel!
    @IBOutlet weak var ivEuroSelected: PaddedImageView!
    
    
    var onBtnDoneTapped: ((_ currency:Currency) -> Void)? = nil
    var selectedCurrency:Currency = Currency.Euro
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        
        self.initialSetup()
        
        self.lblTitle.text = title
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
    
    override func initialSetup() {
        super.initialSetup()
        self.lblDollar.text = Currency.Dollar.name()
        self.lblDollar.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblEuro.text = Currency.Euro.name()
        self.lblEuro.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnEuro?.setShadow()
        btnDollar?.setShadow()
        ivDollarSelected?.setRound()
        ivEuroSelected?.setRound()
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

