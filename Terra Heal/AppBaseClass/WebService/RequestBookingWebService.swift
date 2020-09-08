//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation



class MyBookingData: NSObject {
    var booking_type: String = ""
    var session_id: String = ""
    var special_notes:  String = ""
    var date: String = ""
    var booking_info: [BookingInfo] = []
    var user_id: String = PreferenceHelper.shared.getUserId()
    var shop_id: String = ""
    var currency_id: String = ""
    //Data Not In Web Call
    var serviceCenterDetail: ServiceCenterDetail = ServiceCenterDetail.init(fromDictionary: [:])
    override init() {
        super.init()
    }
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["session_id"] = session_id
        dictionary["booking_date_time"] = date
        dictionary["booking_type"] = booking_type
        dictionary["special_notes"] = special_notes
        dictionary["user_id"] = user_id
        dictionary["shop_id"] = shop_id
        dictionary["currency_id"] = currency_id
        var dictionaryElements = [[String:Any]]()
        for dataElement in booking_info {
            dictionaryElements.append(dataElement.toDictionary())
        }
        dictionary["booking_info"] = dictionaryElements
        return dictionary
    }
    
}

class BookingInfo: NSObject {
    
    
    
    var user_people_id: String = ""
    var location: String = ""
    var notes_of_injuries: String = ""
    var imc_type: String = ""
    var therapist_id: String = ""
    var room_id: String = ""
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
    var notes: String = ""
    var preference: String = ""
    var massage_preference_option_id: String = ""
    
    override init() {
        super.init()
    }
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["massage_prices_id"] = massage_prices_id
        dictionary["preference"] = preference
        dictionary["massage_preference_option_id"] = massage_preference_option_id
        dictionary["notes"] = notes
        return dictionary
    }
}
