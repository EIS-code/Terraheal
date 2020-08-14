//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit
import FSCalendar

class CustomDatePicker: ThemeBottomDialogView {


    @IBOutlet weak var lblSelectedYear: ThemeLabel!
    @IBOutlet weak var lblSelectedDate: ThemeLabel!
    @IBOutlet weak var vwCalendar: FSCalendar!
    @IBOutlet weak var btnPreviousMonth: ThemeButton!
    @IBOutlet weak var btnNextMonth: ThemeButton!
    @IBOutlet weak var vwMainCalender: UIView!

    var onBtnDoneTapped: ((_ date:Double) -> Void)? = nil
    var selectedMilli:Double = 0

    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()

    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, buttonTitle:String, cancelButtonTitle:String) {

        self.initialSetup()

        self.lblTitle.text = title
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }






    }

    override func initialSetup() {
        super.initialSetup()
        self.btnPreviousMonth.setTitle(FontSymbol.back_arrow, for: .normal)
        self.btnPreviousMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnNextMonth.setTitle(FontSymbol.next_arrow, for: .normal)
        self.btnNextMonth.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.setupCalendarView(calendar: vwCalendar)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //vwMainCalender?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
        vwMainCalender?.setShadow()
    }



    @IBAction func btnPreviousTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.previousMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }
    @IBAction func btnNextTapped(_ sender: Any) {
        let currentPage = self.vwCalendar.currentPage.nextMonth()
        self.vwCalendar.setCurrentPage(currentPage, animated: true)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedMilli == 0 {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATE".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedMilli);
            }
        }

    }

}



extension CustomDatePicker: FSCalendarDataSource, FSCalendarDelegate {

    func setupCalendarView(calendar: FSCalendar) {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.allowsMultipleSelection = false
        calendar.appearance.todayColor = UIColor.themeSecondary
        calendar.appearance.caseOptions = .weekdayUsesSingleUpperCase
        calendar.appearance.weekdayFont = FontHelper.font(name: FontName.Regular, size: FontSize.button_14)
        calendar.appearance.weekdayTextColor = UIColor.lightGray
        calendar.appearance.headerTitleFont = FontHelper.font(name: FontName.SemiBold, size: FontSize.button_18)
        calendar.appearance.headerTitleColor = UIColor.darkGray
        

    }
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
            self.selectDate(date: date)
            if monthPosition == .previous || monthPosition == .next {
                calendar.setCurrentPage(date, animated: true)
            }
        
    }
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date.init().addingTimeInterval(-TimeInterval.init(Date.millisecondsOfDay(day: 1)))
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date.init().addingTimeInterval(TimeInterval.init(Date.millisecondsOfDay(day: 3)))
    }
    
    func selectDate(date:Date) {
        self.lblSelectedDate.text = date.toString(format: "EEE, MMM dd")
        self.lblSelectedYear.text = date.toString(format: "yyyy")
        self.vwCalendar.select(date)
        self.selectedMilli = date.millisecondsSince1970
    }
}
