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
        self.btnHours.setTitle(" hours", for: .normal)
    }

    func setData(data:ServiceCenterDetail) {
        self.lblName?.text = data.name
        self.lblAddress?.text = data.address
        self.btnNumberOfServices.setTitle(data.numberOfServices + "+", for: .normal)
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
            guard let self = self else { return } ; print(self)
            hourSelectionDialog?.dismiss()
            self.btnHours.setTitle(" " + hours.day + " " + hours.startHour + " - " + hours.endHour, for: .normal)
        }
        hourSelectionDialog.onBtnCancelTapped = { [weak self, weak hourSelectionDialog] in
            guard let self = self else { return } ; print(self)
            hourSelectionDialog?.dismiss()
        }
        
    }
}




