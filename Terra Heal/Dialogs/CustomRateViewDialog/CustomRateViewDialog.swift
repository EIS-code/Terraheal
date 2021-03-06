//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class CustomRateViewDialog: ThemeBottomDialogView {

    
    @IBOutlet weak var txtDescription: ThemeTextView!
    @IBOutlet weak var ratingView: RatingView!
    var rate:Float = 0.0
    var strEnteredData: String = ""
    var onBtnDoneTapped: ((_ data: String,_ rate: Float) -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String,data: String , buttonTitle:String,cancelButtonTitle:String) {
        self.lblTitle.text = title
        self.txtDescription.text = data
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
        self.initialSetup()
    }

    override func initialSetup() {
        super.initialSetup()
        self.ratingView.delegate = self
        self.txtDescription.setFont(name: FontName.Regular, size: FontSize.header)
        self.txtDescription.placeholder = "Lorem ipsum dolor sit amet,"
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.txtDescription?.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }



    @IBAction func btnDoneTapped(_ sender: Any) {
        strEnteredData = txtDescription.text?.trim() ?? ""
        if strEnteredData.isEmpty()  {
            Common.showAlert(message: "VALIDATION_MSG_INVALID_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(strEnteredData,rate);
            }
        }

    }

}

extension CustomRateViewDialog: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {

    }
}
extension  CustomRateViewDialog : RatingViewDelegate {
    func RatingView(_ ratingView: RatingView, didUpdate rating: Float) {
        self.rate = rating
        print(rating)
    }
}

