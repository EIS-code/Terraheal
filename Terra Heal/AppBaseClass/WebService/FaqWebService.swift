//
//  File.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 23/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum FAQWebService {
    
    struct RequestFAQlist: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        // var token: String = PreferenceHelper.shared.getSessionToken()
    }
    struct RequestFAQDetail: Codable {
        var menu_id: String = "1"
        var user_id: String = PreferenceHelper.shared.getUserId()
        
    }
    class ResponseFAQList: ResponseModel {
       var dataList: [FAQItem] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(FAQItem.init(fromDictionary: data))
                }
            }
        }
    }
    class ResponseMenuDetail: ResponseModel {
        var dataList: [FAQItem] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(FAQItem.init(fromDictionary: data))
                }
            }
        }
    }
}
//MARK: Menu Individual Item
class FAQItem: ResponseModel {
    var question: String = ""
    var id: String = ""
    var answer: String = ""
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.question = (dictionary["question"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.answer = (dictionary["answer"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["question"] = question
        dictionary["answer"] = answer
        dictionary["id"] = id
        return dictionary
    }
}
