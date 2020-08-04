//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum DistanceUnit: String {
    case Kilometre = "km"
    case Mile = "miles"

    func name() -> String {
        switch self
        {
        case .Kilometre:
            return "kilometre"
        case .Mile:
            return "Mile"
        }
    }
    func symbol() -> String {
        switch self
        {
        case .Kilometre:
            return "km"
        case .Mile:
            return "miles"
        }
    }
}
class CustomDistanceUnitPicker: ThemeBottomDialogView {

    @IBOutlet weak var vwMainSelection: UIView!
    @IBOutlet weak var vwOption1: UIView!
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var lblOption1: ThemeLabel!
    @IBOutlet weak var ivOption1Selected: PaddedImageView!
    @IBOutlet weak var vwOption2: UIView!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var lblOption2: ThemeLabel!
    @IBOutlet weak var ivOption2Selected: PaddedImageView!


    var onBtnDoneTapped: ((_ data:DistanceUnit) -> Void)? = nil
    var selectedData:DistanceUnit = DistanceUnit.Kilometre



    //Animation Properties
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

        self.select(data: self.selectedData)
    }

    func select(data:DistanceUnit) {
        self.selectedData = data

        btnOption1.setRound(withBorderColor: (data == DistanceUnit.Kilometre) ? UIColor.themePrimary : UIColor.clear, andCornerRadious: 10.0, borderWidth: 1.5)
        ivOption1Selected.isHidden = (data == DistanceUnit.Kilometre) ? false : true
        ivOption2Selected.isHidden = (data == DistanceUnit.Kilometre) ? true : false
        btnOption2.setRound(withBorderColor: (data == DistanceUnit.Kilometre) ? UIColor.clear : UIColor.themePrimary, andCornerRadious: 10.0, borderWidth: 1.5)
        btnOption2?.setShadow()
        btnOption1?.setShadow()
        ivOption1Selected?.setRound()
        ivOption2Selected?.setRound()
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblOption1.text = Currency.Dollar.name()
        self.lblOption1.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblOption2.text = Currency.Euro.name()
        self.lblOption2.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        btnOption2?.setShadow()
        btnOption1?.setShadow()
        ivOption1Selected?.setRound()
        ivOption2Selected?.setRound()
    }

    @IBAction func btnOption1Tapped(_ sender: Any) {
        self.select(data: DistanceUnit.Kilometre)
    }
    @IBAction func btnOption2Tapped(_ sender: Any) {
        self.select(data: DistanceUnit.Mile)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
    }


}

