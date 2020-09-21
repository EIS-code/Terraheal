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
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }


    struct SaveMassagePrefenceList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
        var data: [PreferenceData] = []
    }
    
    struct PreferenceData: Codable {
           var id: String = ""
           var value: String = ""
    }
    //MARK: Response
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
                    self.isSelected = true
                }
                    
            }
        }
    }
    
    static func getFocusPreferences() -> MassagePreferenceDetail {
        let massagePReferenceOption: MassagePreferenceDetail = MassagePreferenceDetail.init(fromDictionary: [:])
        var arrForMassage: [PreferenceOption] = []
        arrForMassage.removeAll()
        arrForMassage.append(PreferenceOption.init(fromDictionary: ["id": "1", "name":"head", "selected":"true"]))
        arrForMassage.append(PreferenceOption.init(fromDictionary: ["id": "2", "name":"neck", "selected":"false"]))
        arrForMassage.append(PreferenceOption.init(fromDictionary: ["id": "3", "name":"back", "selected":"false"]))
        arrForMassage.append(PreferenceOption.init(fromDictionary: ["id": "4", "name":"leg", "selected":"false"]))
        arrForMassage.append(PreferenceOption.init(fromDictionary: ["id": "5", "name":"shoulder", "selected":"false"]))
        arrForMassage.append(PreferenceOption.init(fromDictionary: ["id": "6", "name":"hand", "selected":"false"]))
        massagePReferenceOption.preferenceOptions = arrForMassage
        massagePReferenceOption.id = "1"
        massagePReferenceOption.name = "Select Focus area"
        return massagePReferenceOption
    }
}


class PreferenceOption{

    var id: String = ""
    var massagePreferenceId: String = ""
    var name: String = ""
    var selected: String = ""
    var value: String = ""
    var icon: String = ""
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
        self.icon = (dictionary["icon"] as? String) ?? ""
        self.isSelected = self.selected.toBool
    }

    
}

enum Session {

    struct RequestList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var booking_type: String = "0"
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }
    //MARK: Response
       class Response: ResponseModel {
           var sessionList: [SessionDetail] = []
           override init(fromDictionary dictionary: [String:Any]) {
               super.init(fromDictionary: dictionary)
               sessionList.removeAll()
               if let dataArray = dictionary["data"] as? [[String:Any]] {
                   for data in dataArray {
                       sessionList.append(SessionDetail.init(fromDictionary: data))
                   }
               }
           }
       }
    

}

class SessionDetail: ResponseModel {
    
    var id: String = ""
    var name: String = ""
    var detail: String = ""
    var icon: String = ""
    var isSelected: Bool = false
    override init(fromDictionary dictionary: [String : Any]) {
        super.init(fromDictionary: dictionary)
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["type"] as? String) ?? ""
        self.detail = (dictionary["descriptions"] as? String) ?? ""
        self.icon = (dictionary["icon"] as? String) ?? ""
        
    }
}

