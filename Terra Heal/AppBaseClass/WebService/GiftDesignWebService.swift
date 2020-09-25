//
//  GiftDesign.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 23/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum GiftDesignWebService {
    
    struct RequestDesignList: Codable {
        var user_id: String = "2"//PreferenceHelper.shared.getUserId()
    }
   
    class Response: ResponseModel {
        var giftDesignList: [GiftDesign] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            giftDesignList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    giftDesignList.append(GiftDesign.init(fromDictionary: data))
                }
            }
        }
    }
}
class GiftDesign {

    var details: String = ""
    var designs: [Design]!
    var id: String = ""
    var name: String = ""

    init(fromDictionary dictionary: [String:Any]){
       designs = [Design]()
        if let designsArray = dictionary["designs"] as? [[String:Any]]{
            for dic in designsArray{
                let value = Design(fromDictionary: dic)
                designs.append(value)
            }
        }
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.details = (dictionary["description"] as? String) ?? ""
    }
    
    func toTheme() -> Theme {
        return Theme.init(id: self.id, name: self.name, isSelected: false)
    }
}
//MARK: - Design Response

class Design {

    var id: String = ""
    var image: String = ""
    var isSelected: Bool = false
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = (dictionary["id"] as? String) ?? ""
        image = (dictionary["image"] as? String) ?? ""
    }

}
