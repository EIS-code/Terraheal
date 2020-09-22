//
//  MenuItemWebService.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 22/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

//MARK: Request Models
enum MenuItemWebService {
    
    struct RequestMenulist: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        // var token: String = PreferenceHelper.shared.getSessionToken()
    }
    struct RequestMenuDetail: Codable {
        var menu_id: String = "1"
        var user_id: String = PreferenceHelper.shared.getUserId()
        
    }
    class ResponseMenuList: ResponseModel {
        var dataList: [MenuItem] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(MenuItem.init(fromDictionary: data))
                }
            }
        }
    }
    class ResponseMenuDetail: ResponseModel {
        var dataList: [MenuItemDetail] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(MenuItemDetail.init(fromDictionary: data))
                }
            }
        }
    }
}
//MARK: Menu Individual Item
class MenuItem: ResponseModel {
    var name: String = ""
    var id: String = ""
    var icon: String = ""
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.name = (dictionary["name"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.icon = (dictionary["icon"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["icon"] = icon
        dictionary["name"] = name
        dictionary["id"] = id
        return dictionary
    }
}


//MARK: Individual Menu Detail
class MenuItemDetail: ResponseModel {
    
    
    var id: String = ""
    var icon: String = ""
    var title: String = ""
    var shortDescription: String = ""
    var detail: String = ""
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.title = (dictionary["title"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.icon = (dictionary["icon"] as? String) ?? ""
        self.shortDescription = (dictionary["short_description"] as? String) ?? ""
        self.detail = (dictionary["description"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["short_description"] = shortDescription
        dictionary["description"] = detail
        dictionary["icon"] = icon
        return dictionary
    }
    
}
