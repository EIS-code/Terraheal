//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum MassagePreference {

    struct RequestMassagePrefenceList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var token: String = PreferenceHelper.shared.getSessionToken()
    }


    class Response: ResponseModel {
        var massagePreferenceList: [MassagePreferenceDetail] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            massagePreferenceList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    massagePreferenceList.append(MassagePreferenceDetail.init(fromDictionary: data))
                }
            }
        }
    }


}

class MassagePreferenceDetail: ResponseModel {

    
    var id: String = ""
    var name: String = ""
    var preferenceOptions: [PreferenceOption] = []
    var type:MassagePreferenceMenu = MassagePreferenceMenu.HealthCondition
    
    var isSelected: Bool = false
    var selectedPreference: PreferenceOption = PreferenceOption(fromDictionary: [:])
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.type = MassagePreferenceMenu.init(rawValue: self.id) ?? MassagePreferenceMenu.HealthCondition
        preferenceOptions.removeAll()
        if let dataArray = dictionary["preference_options"] as? [[String:Any]] {
            for data in dataArray {
                let preferenceOption = PreferenceOption.init(fromDictionary: data)
                preferenceOptions.append(preferenceOption)
                if preferenceOption.selected.toBool {
                    self.selectedPreference = PreferenceOption.init(fromDictionary: data)
                }
                    
            }
        }
    }
}


class PreferenceOption{

    var id: String = ""
    var massagePreferenceId: String = ""
    var name: String = ""
    var selected: String = ""
    var value: String = ""
    var isSelected: Bool = false
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.id = (dictionary["id"] as? String) ?? ""
        self.massagePreferenceId = (dictionary["massage_preference_id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.selected = (dictionary["selected"] as? String) ?? ""
        self.value = (dictionary["value"] as? String) ?? ""
        self.isSelected = self.selected.toBool
    }

}
