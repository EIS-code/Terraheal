//  
//
//  Created by Jaydeep on 19/03/20.
//  Copyright © 2020 com.evolutiondemo. All rights reserved.
//
import UIKit
import Foundation

class ServiceCell: CollectionCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblAddress: ThemeLabel!
    @IBOutlet weak var ivMap: UIImageView!
    @IBOutlet weak var btnHours: UnderlineTextButton!
    @IBOutlet weak var lblServices: ThemeLabel!
    @IBOutlet weak var btnNumberOfServices: ThemeButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblAddress?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblServices?.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        self.btnNumberOfServices?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnNumberOfServices?.setRound()
    }

    func setData(data:ServiceDetail) {
        self.lblName?.text = data.name
        self.lblAddress?.text = data.address
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnNumberOfServices?.setRound()
        self.ivMap?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
    }
    
    @IBAction func btnHourTapped(_ sender: Any) {
        self.openHourSelection()
    }
    
    func openHourSelection() {
        let hourSelectionDialog: CustomServiceHourSelectionDialog = CustomServiceHourSelectionDialog.fromNib()
        hourSelectionDialog.initialize(title: "centers hours", buttonTitle: "", cancelButtonTitle: "")
        hourSelectionDialog.show(animated: true)
        hourSelectionDialog.onBtnDoneTapped = { [weak self, weak hourSelectionDialog] (hours) in
            print(hours.day)
            hourSelectionDialog?.dismiss()
        }
        hourSelectionDialog.onBtnCancelTapped = { [weak self, weak hourSelectionDialog] in
            print("cancel")
            hourSelectionDialog?.dismiss()
        }
        
    }
}




