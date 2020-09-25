//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
enum TherapistQuastionaries {

    struct RequestQuestionList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
    }


    struct SaveQuestionList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
       // var token: String = PreferenceHelper.shared.getSessionToken()
        var data: [QuestionData] = []
    }
    
    struct QuestionData: Codable {
           var id: String = ""
           var value: String = ""
    }
    //MARK: Response
    class Response: ResponseModel {
        var quastionList: [QuestionDetail] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            quastionList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    quastionList.append(QuestionDetail.init(fromDictionary: data))
                }
            }
        }
    }
    
   
   

    
}

class QuestionDetail: ResponseModel {
    var id: String =  ""
    var max: String = ""
    var min: String =  ""
    var placeholder =  ""
    var title: String = ""
    var type: String =  ""
    var value: String  = ""
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.id = (dictionary["id"] as? String) ?? ""
        self.max = (dictionary["max"] as? String) ?? ""
        self.min = (dictionary["min"] as? String) ?? ""
        self.placeholder = (dictionary["placeholder"] as? String) ?? ""
        self.title = (dictionary["title"] as? String) ?? ""
        self.type = (dictionary["type"] as? String) ?? ""
        self.value = (dictionary["value"] as? String) ?? ""
    }
}

