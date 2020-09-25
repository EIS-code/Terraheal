//
//  File.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 24/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum PackageWebService {
    struct RequestPackageList: Codable {
        var shop_id: String = ""
    }
 
    struct RequestBuyPackage: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var user_pack_id: String = ""
        var recipient_name: String? = nil
        var recipient_last_name: String? = nil
        var recipient_second_name: String? = nil
        var recipient_mobile: String? = nil
        var recipient_email: String? = nil
        var giver_first_name: String? = nil
        var giver_last_name: String? = nil
        var giver_mobile: String? = nil
        var giver_email: String? = nil
        var giver_message_to_recipient: String? = nil
        var preference_email: String? = nil
        var preference_email_date: String? = nil
    }
   
    class ResponsePackageList: ResponseModel {
       var dataList: [Package] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(Package.init(fromDictionary: data))
                }
            }
        }
    }
    
    //MARK
}


class Package:ResponseModel {

    var actualAmount: String = ""
    var descriptionField: String = ""
    var expireDate: String = ""
    var id: String = ""
    var retailAmount: String = ""
    var saveAmount: String = ""
    var shopId: String = ""
    var title: String = ""
    var uniqueId: String = ""

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.actualAmount = (dictionary["actual_amount"] as? String) ?? ""
        self.descriptionField = (dictionary["description"] as? String) ?? ""
        self.expireDate = (dictionary["expire_date"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.retailAmount = (dictionary["retail_amount"] as? String) ?? ""
        self.saveAmount = (dictionary["save_amount"] as? String) ?? ""
        self.shopId = (dictionary["shop_id"] as? String) ?? ""
        self.title = (dictionary["title"] as? String) ?? ""
        self.uniqueId = (dictionary["unique_id"] as? String) ?? ""
    }

    func toViewModel() -> PackageDetail {
        PackageDetail.init(id: self.id, name: self.title, price: self.actualAmount, discount: self.saveAmount, isSelected: false)
    }
}


struct MyBookingPackage: Codable {
    var bookingDateTime: String = ""
    var bookingType: String = ""
    var bringTableFuton: String = ""
    var currencyId: String = ""
    var focusAreaPreference: String = ""
    var genderPreference: String = ""
    var imcType: String = ""
    var isPack: String = ""
    var location: String = ""
    var notesOfInjuries: String = ""
    var packId: String = ""
    var packServiceId: String = ""
    var pressurePreference: String = ""
    var roomId: String = ""
    var sessionId: String = ""
    var specialNotes: String = ""
    var tableFutonQuantity: String = ""
    var therapistId: String = ""
    var userId: String = ""
    var userPeopleId: String = ""
}
