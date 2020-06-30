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
        self.tfForContent.text = data.value
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
    

    
}


