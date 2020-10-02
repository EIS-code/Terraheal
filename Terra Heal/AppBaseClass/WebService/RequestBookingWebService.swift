//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation



class CurrentBookingData: NSObject {
    var booking_type: BookingType = BookingType.MassageCenter
    var session_id: String = ""
    var special_notes:  String = ""
    var date: String = ""
    var booking_info: [BookingInfo] = []
    var user_id: String = PreferenceHelper.shared.getUserId()
    var shop_id: String = ""
    var currency_id: String = ""
    var bring_table_futon: String? = nil
    var table_futon_quantity: String? = nil
    
    //Data Not In Web Call
    var serviceCenterDetail: ServiceCenterDetail = ServiceCenterDetail.init(fromDictionary: [:])
    override init() {
        super.init()
    }
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["session_id"] = session_id
        dictionary["booking_date_time"] = date
        dictionary["booking_type"] = booking_type.getParameterId()
        dictionary["special_notes"] = special_notes
        dictionary["user_id"] = user_id
        dictionary["shop_id"] = shop_id
        dictionary["currency_id"] = currency_id
        var dictionaryElements = [[String:Any]]()
        for dataElement in booking_info {
            dictionaryElements.append(dataElement.toDictionary())
        }
        dictionary["booking_info"] = dictionaryElements
        if bring_table_futon != nil {
            dictionary["bring_table_futon"] = bring_table_futon
        }
        if table_futon_quantity != nil {
            dictionary["table_futon_quantity"] = table_futon_quantity!
        }
        return dictionary
    }
    
}

class BookingInfo: NSObject {
    
    
    
    var user_people_id: String = ""
    var location: String = "Rajkot"
    var notes_of_injuries: String = "1"
    var imc_type: String = "1"
    var therapist_id: String = "1"
    var room_id: String = "1"
    var massage_info: [MyMassageInfo] = []
    var massagePreferenceOptionId : String = ""
    var preference : String = ""
   
    
    //Data Not In Web Call
    var reciepent:People = People.init(fromDictionary: [:])
    var services: [ServiceDetail] = []
    
    override init() {
        super.init()
    }
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["user_people_id"] = user_people_id
        dictionary["location"] = location
        dictionary["notes_of_injuries"] = notes_of_injuries
        dictionary["imc_type"] = imc_type
        dictionary["therapist_id"] = therapist_id
        dictionary["room_id"] = room_id
        var dictionaryElements = [[String:Any]]()
        for dataElement in massage_info {
            dictionaryElements.append(dataElement.toDictionary())
        }
        dictionary["massage_info"] = dictionaryElements
        
        return dictionary
    }
}

class MyMassageInfo: NSObject {
    
    var massage_prices_id: String = ""
    var notes_of_injuries: String = ""
    var gender_preference: String = ""
    var pressure_preference: String = ""
    var focus_area_preference: String = ""
    override init() {
        super.init()
    }
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["massage_prices_id"] = massage_prices_id
        dictionary["gender_preference"] = gender_preference
        dictionary["pressure_preference"] = pressure_preference
        dictionary["notes_of_injuries"] = notes_of_injuries
        dictionary["focus_area_preference"] = focus_area_preference
        return dictionary
    }
}
