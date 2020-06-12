//  EvolutionDemo
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation


struct EditProfileTextFieldDetail {
    var vlaue:String = ""
    var placeholder:String = ""
    var isMadatory:Bool = true
    var contentType = "email"
}

class EditProfileCell: CollectionCell {

    @IBOutlet weak var vwEditText: UIView!
    @IBOutlet weak var tfForContent: EditProfileTextfield!
    var labelPlaceholder: ThemeLabel = ThemeLabel()
    override class func awakeFromNib() {
        super.awakeFromNib()

    }

    func setData(data:EditProfileTextFieldDetail) {
        self.tfForContent.placeholder = data.placeholder
        self.tfForContent.text = data.vlaue
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
    }

    func addFloatingLabel(){
        print(tfForContent.leftView)
    }
}




