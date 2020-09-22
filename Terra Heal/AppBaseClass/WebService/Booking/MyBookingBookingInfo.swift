//
//	MyBookingBookingInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MyBookingInfo{

	var bookingCurrencyId: String = ""
	var bookingId: String = ""
	var bookingMassages : [MyBookingMassage] = []
	var cancelledReason: String = ""
	var id: String = ""
	var imcType: String = ""
	var isCancelled: String = ""
	var isDone: String = ""
	var location: String = ""
	var massageDate: String = ""
	var massageTime: String = ""
	var roomId: String = ""
	var shopCurrencyId: String = ""
	var therapistId: String = ""
	var userPeopleId: String = ""


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		
        self.bookingMassages = [MyBookingMassage]()
		if let bookingMassagesArray = dictionary["booking_massages"] as? [[String:Any]]{
			for dic in bookingMassagesArray{
				let value = MyBookingMassage(fromDictionary: dic)
				self.bookingMassages.append(value)
			}
		}
        self.bookingCurrencyId = (dictionary["booking_currency_id"] as? String) ?? ""
        self.bookingId = (dictionary["booking_id"] as? String) ?? ""
        self.cancelledReason = (dictionary["cancelled_reason"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.imcType = (dictionary["imc_type"] as? String) ?? ""
        self.isCancelled = (dictionary["is_cancelled"] as? String) ?? ""
        self.isDone = (dictionary["is_done"] as? String) ?? ""
        self.location = (dictionary["location"] as? String) ?? ""
        self.massageDate = (dictionary["massage_date"] as? String) ?? ""
        self.massageTime = (dictionary["massage_time"] as? String) ?? ""
        self.roomId = (dictionary["room_id"] as? String) ?? ""
        self.shopCurrencyId = (dictionary["shop_currency_id"] as? String) ?? ""
        self.therapistId = (dictionary["therapist_id"] as? String) ?? ""
        self.userPeopleId = (dictionary["user_people_id"] as? String) ?? ""
	}

}
