//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class ServiceCenterDetailDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var ivMassageCenter: PaddedImageView!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblAddress: ThemeLabel!
    @IBOutlet weak var ivMap: UIImageView!
    @IBOutlet weak var lblServices: ThemeLabel!
    @IBOutlet weak var btnNumberOfServices: ThemeButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var lblDetails: ThemeLabel!
    
    var onBtnDoneTapped: (( ) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(data:ServiceCenterDetail,buttonTitle: String) {
        self.initialSetup()
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        self.lblDetails?.text = data.serviceDetails
        self.lblName?.text = data.name
        self.lblAddress?.text = data.address
        self.btnNumberOfServices.setTitle(data.totalServices + "+", for: .normal)
        self.scrVw.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 60, right: 0)
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.contentView.clipsToBounds = true
        self.scrVw.clipsToBounds = true
        contentView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        scrVw.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblAddress?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblServices?.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        self.btnNumberOfServices?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnNumberOfServices?.setRound()
        self.setDataForStepUpAnimation(data: [0.75,0.9])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivMassageCenter?.layoutIfNeeded()
        self.ivMassageCenter?.setRound()
        self.contentView?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.scrVw?.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!();
        }
    }
    
}
