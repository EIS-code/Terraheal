//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum ManagePeople {
    
    struct RequestPeoplelist: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        //var token: String = PreferenceHelper.shared.getSessionToken()
    }
    struct RequestUpdatePeople: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var name: String = ""
        var age: String = ""
        var gender: String = ""
        var id: String = ""
        var user_gender_preference_id: String = ""
        
    }
    struct RequestDeletePeople: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var id: String = ""
    }
    
    struct RequestAddPeoples: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var name: String = ""
        var age: String = ""
        var gender: String = ""
        var user_gender_preference_id: String = ""
    }
    
    
    class Response: ResponseModel {
        var peopleList: [People] = []
        var people: People = People.init(fromDictionary: [:])
        var preferenceOptions: [PreferenceOption] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            peopleList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    peopleList.append(People.init(fromDictionary: data))
                }
            } else if let dict = dictionary["data"] as? [String:Any] {
                self.people  = People.init(fromDictionary: dict)
            }
            preferenceOptions.removeAll()
            if let dataArray = dictionary["gender_preferences"] as? [[String:Any]] {
                for data in dataArray {
                    let preferenceOption = PreferenceOption.init(fromDictionary: data)
                    preferenceOptions.append(preferenceOption)
                }
            }
        }
    }
}

class People: ResponseModel {
    
    var isSelected: Bool = false
    var name: String = ""
    var age: String = ""
    var photo: String = ""
    var gender: String = ""
    var id: String = ""
    var userGenderPreferenceId: String = ""
    var userId: String = PreferenceHelper.shared.getUserId()
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.name = (dictionary["name"] as? String) ?? ""
        self.photo = (dictionary["photo"] as? String) ?? ""
        self.age = (dictionary["age"] as? String) ?? ""
        self.gender = (dictionary["gender"] as? String) ?? ""
        self.userGenderPreferenceId = (dictionary["user_gender_preference_id"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.userId = (dictionary["user_id"] as? String) ?? ""
    }
    
    func getGenderName() -> String {
        return Gender.init(rawValue: self.gender)?.name() ?? Gender.Male.name()
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["age"] = age
        dictionary["gender"] = gender
        dictionary["name"] = name
        dictionary["id"] = id
        dictionary["photo"] = photo
        dictionary["user_id"] = userId
        dictionary["user_gender_preference_id"] = userGenderPreferenceId
        return dictionary
    }
    
    func toUpdateRequest() -> ManagePeople.RequestUpdatePeople {
        var updateRequest = ManagePeople.RequestUpdatePeople()
        updateRequest.gender =  self.gender
        updateRequest.age = self.age
        updateRequest.name = self.name
        updateRequest.id = self.id
        updateRequest.id = self.id
        updateRequest.user_gender_preference_id = self.userGenderPreferenceId
        return updateRequest
    }
    func toAddRequest() -> ManagePeople.RequestAddPeoples {
        var addRequest = ManagePeople.RequestAddPeoples()
        addRequest.gender =  self.gender
        addRequest.age = self.age
        addRequest.name = self.name
        addRequest.user_gender_preference_id = self.userGenderPreferenceId
        return addRequest
    }
}
