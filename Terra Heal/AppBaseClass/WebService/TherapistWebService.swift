//
//  TherapistWebService.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 18/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum TherapistWebService {
    
    struct RequestBookingTherapist: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
    }
    
    struct RequestSaveRating: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var therapist_id: String = ""
        var rating: String = ""
        var message: String = ""
    }
    
    class Response: ResponseModel {
        var therapistList: [Therapist] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            therapistList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    therapistList.append(Therapist.init(fromDictionary: data))
                }
            }
        }
    }
}

class Therapist: ResponseModel{

    var appVersion: String = ""
    var avatar: String = ""
    var avatarOriginal: String = ""
    var deviceToken: String = ""
    var deviceType: String = ""
    var dob: String = ""
    var email: String = ""
    var gender: String = ""
    var hobbies: String = ""
    var id: String = ""
    var isDocumentVerified: String = ""
    var isEmailVerified: String = ""
    var isFreelancer: String = ""
    var isMobileVerified: String = ""
    var name: String = ""
    var oauthProvider: String = ""
    var oauthUid: String = ""
    var paidPercentage: String = ""
    var profilePhoto: String = ""
    var shopId: String = ""
    var shortDescription: String = ""
    var telNumber: String = ""

    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.appVersion = (dictionary["app_version"] as? String) ?? ""
        self.avatar = (dictionary["avatar"] as? String) ?? ""
        self.avatarOriginal = (dictionary["avatar_original"] as? String) ?? ""
        self.deviceToken = (dictionary["device_token"] as? String) ?? ""
        self.deviceType = (dictionary["device_type"] as? String) ?? ""
        self.dob = (dictionary["dob"] as? String) ?? ""
        self.email = (dictionary["email"] as? String) ?? ""
        self.gender = (dictionary["gender"] as? String) ?? ""
        self.hobbies = (dictionary["hobbies"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.isDocumentVerified = (dictionary["is_document_verified"] as? String) ?? ""
        self.isEmailVerified = (dictionary["is_email_verified"] as? String) ?? ""
        self.isFreelancer = (dictionary["is_freelancer"] as? String) ?? ""
        self.isMobileVerified = (dictionary["is_mobile_verified"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.oauthProvider = (dictionary["oauth_provider"] as? String) ?? ""
        self.oauthUid = (dictionary["oauth_uid"] as? String) ?? ""
        self.paidPercentage = (dictionary["paid_percentage"] as? String) ?? ""
        self.profilePhoto = (dictionary["profile_photo"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.shortDescription = (dictionary["short_description"] as? String) ?? ""
        self.telNumber = (dictionary["tel_number"] as? String) ?? ""
    }

    func toViewModel() -> MyTherapistDetail {
        return MyTherapistDetail.init(name: self.name, image: self.profilePhoto, isSelected: false)
    }
}
