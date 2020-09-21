//
//  MyPlacesWebService.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 18/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum PlacesWebService {
    
    struct RequestBookingPlaces: Codable {
        var user_id: String = "18"//PreferenceHelper.shared.getUserId()
    }
    
    class Response: ResponseModel {
        var placesList: [Place] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            placesList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    placesList.append(Place.init(fromDictionary: data))
                }
            }
        }
    }
}


class Place: ResponseModel {

    var address : String = ""
    var cityId : String = ""
    var closeTime : String = ""
    var countryId : String = ""
    var currencyId : String = ""
    var descriptionField : String = ""
    var email : String = ""
    var id : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var name : String = ""
    var openDayFrom : String = ""
    var openDayTo : String = ""
    var openTime : String = ""
    var ownerEmail : String = ""
    var ownerMobileNumber : String = ""
    var ownerName : String = ""
    var password : String = ""
    var telNumber : String = ""
    var timeZone : String = ""
    var totalServices : String = ""
    var userName : String = ""

    
    
    var isSelected: Bool = false

    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.address = (dictionary["address"] as? String) ?? ""
        self.cityId = (dictionary["city_id"] as? String) ?? ""
        self.countryId = (dictionary["country_id"] as? String) ?? ""
        self.currencyId = (dictionary["currency_id"] as? String) ?? ""
        self.email = (dictionary["email"] as? String) ?? ""         
        self.id = (dictionary["id"] as? String) ?? ""
        self.latitude = (dictionary["latitude"] as? String) ?? ""
        self.longitude = (dictionary["longitude"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.ownerEmail = (dictionary["owner_email"] as? String) ?? ""
        self.ownerMobileNumber = (dictionary["owner_mobile_number"] as? String) ?? ""
        self.ownerName = (dictionary["owner_name"] as? String) ?? ""
        self.password = (dictionary["password"] as? String) ?? ""
        self.telNumber = (dictionary["tel_number"] as? String) ?? ""
        self.timeZone = (dictionary["time_zone"] as? String) ?? ""
        self.userName = (dictionary["user_name"] as? String) ?? ""
    }

}
