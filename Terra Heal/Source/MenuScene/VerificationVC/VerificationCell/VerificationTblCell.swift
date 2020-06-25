//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class VerificationTblCell: TableCell {

    @IBOutlet weak var vwEditText: UIView!
    @IBOutlet weak var tfForContent: EditProfileTextfield!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var imgVerified: UIImageView!
    var data: EditProfileTextFieldDetail!


    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    func setData(data:EditProfileTextFieldDetail) {
        self.data = data
        self.tfForContent.placeholder = data.placeholder
        self.tfForContent.text = data.vlaue
        if data.contentType == TextFieldContentType.Email  {
            self.btnVerify.isHidden = appSingleton.user.isEmailVerified.toBool
            self.imgVerified.isHidden = !appSingleton.user.isEmailVerified.toBool
        } else if data.contentType ==  TextFieldContentType.Phone {
            self.btnVerify.isHidden = appSingleton.user.isMobileVerified.toBool
            self.imgVerified.isHidden = !appSingleton.user.isMobileVerified.toBool
        } else {
            self.btnVerify.isHidden = true
            self.imgVerified.isHidden = true
        }
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
    }
    @IBAction func btnVerifyTapped(_ sender: Any) {
        if self.data.contentType == .Email {
            self.openEmailVerification()
        } else if self.data.contentType == .Phone {
            self.openMobileVerification()
        }

    }

    func openEmailVerification() {
        let alertForVerification: VerificationAlert  = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_EMAIL_TITLE".localized(), data: Singleton.shared.user.email)
        alertForVerification.show(animated: true)
        alertForVerification.setVerificationFor(type: .Email)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            alertForVerification?.dismiss()
            Common.appDelegate.loadVerifiedContactVC()
        }

        alertForVerification.onBtnResendTapped = { [weak self] in

        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            alertForVerification?.dismiss()
        }
    }
    func openMobileVerification() {
        let alertForVerification: VerificationAlert  = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_MOBILE_TITLE".localized(), data: Singleton.shared.user.telNumber)
        alertForVerification.show(animated: true)
        alertForVerification.setVerificationFor(type: .Phone)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            alertForVerification?.dismiss()
            Common.appDelegate.loadVerifiedContactVC()
        }

        alertForVerification.onBtnResendTapped = { [weak self] in

        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            alertForVerification?.dismiss()
        }
    }
}


