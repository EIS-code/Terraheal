//
//	MyBookingData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MyPastBookingData{

    var bookingDateTime: String = ""
	var bookingInfo : [MyBookingInfo] = []
    var bookingType: String = ""
    var bringTableFuton: String = ""
    var copyWithId: String = ""
    var createdAt: String = ""
    var id: String = ""
    var sessionId: String = ""
    var shopId: String = ""
    var specialNotes: String = ""
    var tableFutonQuantity: String = ""
    var updatedAt: String = ""
    var userId: String = ""
    var isSelected: Bool = false


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        self.bookingDateTime = (dictionary["booking_date_time"] as? String) ?? ""
        self.bookingInfo = [MyBookingInfo]()
		if let bookingInfoArray = dictionary["booking_info"] as? [[String:Any]] {
			for dic in bookingInfoArray{
				let value = MyBookingInfo(fromDictionary: dic)
				self.bookingInfo.append(value)
			}
		}
        self.bookingType = (dictionary["booking_type"] as? String) ?? ""
        self.bringTableFuton = (dictionary["bring_table_futon"] as? String) ?? ""
        self.copyWithId = (dictionary["copy_with_id"] as? String) ?? ""
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.sessionId = (dictionary["session_id"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.specialNotes = (dictionary["special_notes"] as? String) ?? ""
        self.tableFutonQuantity = (dictionary["table_futon_quantity"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
        self.userId = (dictionary["user_id"] as? String) ?? ""
	}

}
