//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit
struct HoursDetails {
    var day: String = ""
    var startHour: String = ""
    var endHour: String = ""
    
    func getDemoArray() -> [HoursDetails] {
        let hourDetail1: HoursDetails = HoursDetails.init(day: "mon", startHour: "9am", endHour: "5pm")
        let hourDetail2: HoursDetails = HoursDetails.init(day: "tue", startHour: "9am", endHour: "5pm")
        let hourDetail3: HoursDetails = HoursDetails.init(day: "wed", startHour: "9am", endHour: "5pm")
        let hourDetail4: HoursDetails = HoursDetails.init(day: "thu", startHour: "9am", endHour: "5pm")
        let hourDetail5: HoursDetails = HoursDetails.init(day: "fri", startHour: "9am", endHour: "5pm")
        let hourDetail6: HoursDetails = HoursDetails.init(day: "sat", startHour: "9am", endHour: "5pm")
        let hourDetail7: HoursDetails = HoursDetails.init(day: "sun", startHour: "9am", endHour: "5pm")
        
        var arrFortime: [HoursDetails] = []
        arrFortime.append(hourDetail1)
        arrFortime.append(hourDetail2)
        arrFortime.append(hourDetail3)
        arrFortime.append(hourDetail4)
        arrFortime.append(hourDetail5)
        arrFortime.append(hourDetail6)
        arrFortime.append(hourDetail7)
        return arrFortime
    }
}
class CustomServiceHourSelectionCell: TableCell {

    @IBOutlet weak var lblDay: ThemeLabel!
    @IBOutlet weak var lblHours: ThemeLabel!
    @IBOutlet weak var ivTime: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.lblDay?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblHours?.setFont(name: FontName.Bold, size: FontSize.label_18)
    }

    func setData(data: HoursDetails ) {
        if data.day == "mon" {
            self.ivTime.isHidden  = false
        } else {
            self.ivTime.isHidden  = true
        }
        self.lblDay.text = data.day
        self.lblHours.text = data.startHour + " to " + data.endHour
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
