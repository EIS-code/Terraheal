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
    struct RequestPurchasedPackageList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
    }
    struct RequestPackageServiceList: Codable {
        var user_pack_id: String = ""
    }
    
    struct RequestToUsePackage: Codable {
        var booking_type: String = ""
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
    
    class ResponsePurchasedPackageList: ResponseModel {
       var dataList: [PurchasedPackage] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(PurchasedPackage.init(fromDictionary: data))
                }
            }
        }
    }
    
    class ResponsePackageServiceList: ResponseModel {
       var dataList: [PackService] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            dataList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    dataList.append(PackService.init(fromDictionary: data))
                }
            }
        }
    }
}
class PackService {
    var image: String = ""
    var name: String = ""
    var time: String = ""
    var amount: String = ""
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.image = (dictionary["image"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.time = (dictionary["time"] as? String) ?? ""
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["image"] = image
        dictionary["name"] = name
        dictionary["time"] = time
        return dictionary
    }
    
    func toViewModel() -> PackageServiceDetail {
        return PackageServiceDetail.init(id: "", name: self.name, image: self.image, duration: self.time, isSelected: false, isUsed: false)
    }
}
class PurchasedPackage: ResponseModel {
    var actualAmount : String =  ""
    var descriptionField : String =  ""
    var expireDate : String =  ""
    var id : String =  ""
    var retailAmount : String =  ""
    var saveAmount : String =  ""
    var shopId : String =  ""
    var title : String =  ""
    var uniqueId : String =  ""
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

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["actual_amount"] = actualAmount
        dictionary["description"] = descriptionField
        dictionary["expire_date"] = expireDate
        dictionary["id"] = id
        dictionary["retail_amount"] = retailAmount
        dictionary["save_amount"] = saveAmount
        dictionary["shop_id"] = shopId
        dictionary["title"] = title
        dictionary["unique_id"] = uniqueId
        return dictionary
    }
    
    func toViewModel() -> PackDetail {
        return PackDetail.init(code: self.code, name: self.title, price: self.saveAmount, date: self.expireDate, description: self.descriptionField, isSelected: false)
    }
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
class MyBookingPackageData: NSObject {
    var booking_type: BookingType = BookingType.MassageCenter
    var session_id: String = ""
    var special_notes:  String = ""
    var selectedServices: [PackService] = []
    var booking_info : [PackageBookingInfo] = []
    var date: String = ""
    var user_id: String = PreferenceHelper.shared.getUserId()
    var shop_id: String = ""
    var currency_id: String = ""
    var bring_table_futon: String? = nil
    var table_futon_quantity: String? = nil
    
    override init() {
        super.init()
    }
    
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["session_id"] = session_id
        dictionary["booking_date_time"] = date
        dictionary["booking_type"] = booking_type
        dictionary["special_notes"] = special_notes
        dictionary["user_id"] = user_id
        dictionary["shop_id"] = shop_id
        dictionary["currency_id"] = currency_id
        var dictionaryElements = [[String:Any]]()
        for dataElement in booking_info {
            dictionaryElements.append(dataElement.toDictionary())
        }
        dictionary["booking_info"] = dictionaryElements
        if bring_table_futon != nil {
            dictionary["bring_table_futon"] = bring_table_futon
        }
        if table_futon_quantity != nil {
            dictionary["table_futon_quantity"] = table_futon_quantity!
        }
        return dictionary
    }
    
}
class PackageBookingInfo: NSObject {
    var user_people_id: String = ""
    var location: String = "Rajkot"
    var notes_of_injuries: String = "1"
    var imc_type: String = "1"
    var therapist_id: String = "1"
    var room_id: String = "1"
    var massagePreferenceOptionId : String = ""
    var preference : String = ""
    //Data Not In Web Call
    var reciepent:People = People.init(fromDictionary: [:])
    var services: [PackService] = []
    override init() {
        super.init()
    }
    func toDictionary() ->  [String:Any] {
        var dictionary = [String:Any]()
        dictionary["user_people_id"] = user_people_id
        dictionary["location"] = location
        dictionary["notes_of_injuries"] = notes_of_injuries
        dictionary["imc_type"] = imc_type
        dictionary["therapist_id"] = therapist_id
        dictionary["room_id"] = room_id
        return dictionary
    }
}

