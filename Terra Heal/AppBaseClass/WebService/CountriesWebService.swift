//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum Countries {

    struct RequestCountrylist: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
        var token: String = PreferenceHelper.shared.getSessionToken()
    }


    class Response: ResponseModel {
        var countryList: [Country] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            countryList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    countryList.append(Country.init(fromDictionary: data))
                }
            }
        }
    }


}



class Country: ResponseModel {

    var createdAt: String = ""
    var id: String = ""
    var iso3: String = ""
    var name: String = ""
    var shortName: String = ""
    var updatedAt: String = ""
    var isSelected: Bool = false

    /**s
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.iso3 = (dictionary["iso3"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.shortName = (dictionary["short_name"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }

    static func getDemoArray() -> [Country] {
        var arrForCountries: [Country] = []
        arrForCountries.removeAll()
        for i in 0...15 {

            let country: Country = Country.init(fromDictionary: [:])
            country.name = "Coutry - \(i)"
            if i % 2 == 0 {
                country.name = "Abcd - \(i)"
            }
            arrForCountries.append(country)
        }
        return arrForCountries
    }

}
