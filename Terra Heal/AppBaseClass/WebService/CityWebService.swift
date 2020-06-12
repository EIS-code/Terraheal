//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum Cities {

    struct RequestCitylist: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var token: String = PreferenceHelper.shared.getSessionToken()
        var country_id: String = ""
    }


    class Response: ResponseModel {
        var cityList: [City] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            cityList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    cityList.append(City.init(fromDictionary: data))
                }
            }
        }
    }
}

class City: ResponseModel {

    var createdAt: String = ""
    var id: String = ""
    var provinceId: String = ""
    var name: String = ""
    var updatedAt: String = ""
    var isSelected:Bool = false

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.provinceId = (dictionary["province_id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
    static func getDemoArray() -> [City] {
        var arrForCities: [City] = []
        arrForCities.removeAll()
        for i in 0...15 {

            let country: City = City.init(fromDictionary: [:])
            country.name = "City - \(i)"
            if i % 2 == 0 {
                country.name = "Abcd - \(i)"
            }
            arrForCities.append(country)
        }
        return arrForCities
    }
}
