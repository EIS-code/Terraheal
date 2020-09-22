//
//	MyBookingBookingMassage.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MyBookingMassage{

	var bookingInfoId:String = ""
	var cost:String = ""
	var exchangeRate:String = ""
	var focusAreaPreference:String = ""
	var genderPreference:String = ""
	var id:String = ""
	var massagePricesId:String = ""
	var massageTimingId:String = ""
	var notesOfInjuries:String = ""
	var origionalCost:String = ""
	var origionalPrice:String = ""
	var pressurePreference:String = ""
	var price:String = ""
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        self.bookingInfoId = (dictionary["booking_info_id"] as? String) ?? ""
        self.cost = (dictionary["cost"] as? String) ?? ""
        self.exchangeRate = (dictionary["exchange_rate"] as? String) ?? ""
        self.focusAreaPreference = (dictionary["focus_area_preference"] as? String) ?? ""
        self.genderPreference = (dictionary["gender_preference"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.massagePricesId = (dictionary["massage_prices_id"] as? String) ?? ""
        self.massageTimingId = (dictionary["massage_timing_id"] as? String) ?? ""
        self.notesOfInjuries = (dictionary["notes_of_injuries"] as? String) ?? ""
        self.origionalCost = (dictionary["origional_cost"] as? String) ?? ""
        self.origionalPrice = (dictionary["origional_price"] as? String) ?? ""
        self.pressurePreference = (dictionary["pressure_preference"] as? String) ?? ""
        self.price = (dictionary["price"] as? String) ?? ""
	}

}
