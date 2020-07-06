//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum PriceAndLocation {

    struct RequestLocationlist: Codable {
        var id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }


    class Response: ResponseModel {
        var locationList: [PricingLocation] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            locationList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    locationList.append(PricingLocation.init(fromDictionary: data))
                }
            }
        }
    }


}

class PricingLocation: ResponseModel {

    var createdAt: String = ""
    var id: String = ""
    var name: String = ""
    var country_id: String = ""
    var updatedAt: String = ""
    var isSelected: Bool = false

    /**s
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.country_id = (dictionary["country_id"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }

    static func getDemoArray() -> [PricingLocation] {
        var arrForCountries: [PricingLocation] = []
        arrForCountries.removeAll()
        for i in 0...15 {

            let country: PricingLocation = PricingLocation.init(fromDictionary: [:])
            country.name = "Location - \(i)"
            if i % 2 == 0 {
                country.name = "Abcd - \(i)"
            }
            arrForCountries.append(country)
        }
        return arrForCountries
    }

}
