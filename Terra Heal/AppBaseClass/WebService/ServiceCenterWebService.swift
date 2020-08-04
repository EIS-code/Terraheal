//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation
import CoreLocation

//MARK: Request Models
enum ServiceCenter {
    
    struct RequestServiceCenterlist: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var latitude: String = appSingleton.myLatitude
        var longitude: String = appSingleton.myLongitude
        // var token: String = PreferenceHelper.shared.getSessionToken()
    }
    struct RequestServiceCenterDetail: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
        var shop_id: String = "5"
    }
    
    class Response: ResponseModel {
        var serviceCenterList: [ServiceCenterDetail] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            serviceCenterList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    serviceCenterList.append(ServiceCenterDetail.init(fromDictionary: data))
                }
            }
        }
    }
    class ServiceCenterDetailResponse: ResponseModel {
        var serviceList: [ServiceDetail] = []
        override init(fromDictionary dictionary: [String : Any]) {
            super.init(fromDictionary: dictionary)
            serviceList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    serviceList.append(ServiceDetail.init(fromDictionary: data))
                }
            }
        }
    }
}

class CenterHour: ResponseModel {
    var fri: String = "09AM to 05PM";
    var mon: String = "09AM to 05PM";
    var sat: String = "09AM to 05PM";
    var sun: String = "";
    var thu: String = "09AM to 05PM";
    var tue: String = "09AM to 05PM";
    var wed: String = "09AM to 05PM";
    override init(fromDictionary dictionary: [String : Any]) {
        super.init(fromDictionary: [:])
        self.fri = (dictionary["fri"] as? String) ?? ""
        self.mon = (dictionary["mon"] as? String) ?? ""
        self.sat = (dictionary["sat"] as? String) ?? ""
        self.sun = (dictionary["sun"] as? String) ?? ""
        self.thu = (dictionary["thu"] as? String) ?? ""
        self.tue = (dictionary["tue"] as? String) ?? ""
        self.wed = (dictionary["wed"] as? String) ?? ""
    }
    
    func startHour(data:String) -> String {
        return data.components(separatedBy: " ").first ?? ""
    }
    
    func endHour(data:String) -> String {
        return data.components(separatedBy: " ").last ?? ""
    }
    
    func getHours() -> [HoursDetails] {
        let monDay = HoursDetails.init(day: "mon", startHour: self.startHour(data: self.mon), endHour: self.endHour(data: self.endHour(data: self.mon)))
        let tueDay = HoursDetails.init(day: "tue", startHour: self.startHour(data: self.tue), endHour: self.endHour(data: self.endHour(data: self.tue)))
        let wedDay = HoursDetails.init(day: "wed", startHour: self.startHour(data: self.wed), endHour: self.endHour(data: self.endHour(data: self.wed)))
        let thuDay = HoursDetails.init(day: "thu", startHour: self.startHour(data: self.thu), endHour: self.endHour(data: self.endHour(data: self.thu)))
        let friDay = HoursDetails.init(day: "fri", startHour: self.startHour(data: self.fri), endHour: self.endHour(data: self.endHour(data: self.fri)))
        let satDay = HoursDetails.init(day: "sat", startHour: self.startHour(data: self.sat), endHour: self.endHour(data: self.endHour(data: self.sat)))
        let sunDay = HoursDetails.init(day: "sun", startHour: self.startHour(data: self.sun), endHour: self.endHour(data: self.endHour(data: self.sun)))
        return [monDay,tueDay,wedDay,thuDay,friDay,satDay,sunDay]
    }
}
class ServiceCenterDetail: ResponseModel {
    
    var id:String = ""
    var name:String = ""
    var address:String = ""
    var totalServices: String = ""
    var serviceDetails: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var descriptionField : String!
    var image : String!
    var data : [ServiceDetail]!
    var isSelected: Bool = false
    var centerHours: CenterHour = CenterHour.init(fromDictionary: [:])
    var hours: [HoursDetails] = []
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.image = (dictionary["image"] as? String) ?? ""
        self.descriptionField = (dictionary["description"] as? String) ?? ""
        self.address = (dictionary["address"] as? String) ?? ""
        self.totalServices = (dictionary["total_services"] as? String) ?? ""
        self.serviceDetails = (dictionary[""] as? String) ?? ""
        self.latitude = (dictionary["latitude"] as? String) ?? ""
        self.longitude = (dictionary["longitude"] as? String) ?? ""
        self.isSelected = false
        if let dictData = dictionary["center_hours"] as? [String:Any] {
            self.centerHours = CenterHour.init(fromDictionary: dictData)
            self.hours = self.centerHours.getHours()
        }
        if let timingArray = dictionary["data"] as? [[String:Any]] {
            for dic in timingArray{
                let value = ServiceDetail(fromDictionary: dic)
                data.append(value)
            }
        }
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["address"] = address
        dictionary["name"] = name
        dictionary["id"] = id
        dictionary["latitude"] = latitude
        dictionary["longitude"] = longitude
        dictionary["total_services"] = totalServices
        return dictionary
    }
    
    func getCoordinatte() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude.toDouble, longitude: self.longitude.toDouble)
    }
}



class ServiceDetail : ResponseModel {
    
    var createdAt: String = ""
    var details: String = ""
    var id: String = ""
    var image: String = ""
    var name: String = ""
    var duration: [ServiceDurationDetail]!
    var updatedAt: String = ""
    var isSelected: Bool = false
    var selectedDuration: ServiceDurationDetail = ServiceDurationDetail.init(fromDictionary: [:])
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]){
        super.init(fromDictionary: dictionary)
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.details = (dictionary["description"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.image = (dictionary["image"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.duration = [ServiceDurationDetail]()
        if let timingArray = dictionary["timing"] as? [[String:Any]]{
            for dic in timingArray{
                let value = ServiceDurationDetail(fromDictionary: dic)
                duration.append(value)
            }
        }
        updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["description"] = details
        dictionary["id"] = id
        dictionary["image"] = image
        dictionary["name"] = name
        var dictionaryElements = [[String:Any]]()
        for timingElement in duration {
            dictionaryElements.append(timingElement.toDictionary())
        }
        dictionary["timing"] = dictionaryElements
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
    
    
}



class ServiceDurationDetail: ResponseModel {
    
    var createdAt: String = ""
    var id: String = ""
    var massageId: String = ""
    var pricing: Pricing = Pricing.init(fromDictionary: [:])
    var time: String = ""
    var updatedAt: String = ""
    var isSelected: Bool = false
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.createdAt = (dictionary["created_at"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.massageId = (dictionary["massage_id"] as? String) ?? ""
        if let dic = dictionary["pricing"] as? [String:Any]{
            self.pricing = Pricing(fromDictionary: dic)
            
        }
        self.time = (dictionary["time"] as? String) ?? ""
        self.updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any]  {
        var dictionary = [String:Any]()
        dictionary["created_at"] = createdAt
        dictionary["id"] = id
        dictionary["massage_id"] = massageId
        dictionary["pricing"] = pricing.toDictionary()
        dictionary["time"] = time
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
}

class Pricing : ResponseModel {
    
    var cost : String = ""
    var createdAt : String = ""
    var id : String = ""
    var massageId : String = ""
    var massageTimingId : String = ""
    var price : String = ""
    var updatedAt : String = ""
    
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        cost = (dictionary["cost"] as? String) ?? ""
        createdAt = (dictionary["created_at"] as? String) ?? ""
        id = (dictionary["id"] as? String) ?? ""
        massageId = (dictionary["massage_id"] as? String) ?? ""
        massageTimingId = (dictionary["massage_timing_id"] as? String) ?? ""
        price = (dictionary["price"] as? String) ?? ""
        updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["cost"] = cost
        dictionary["created_at"] = createdAt
        dictionary["id"] = id
        dictionary["massage_id"] = massageId
        dictionary["massage_timing_id"] = massageTimingId
        dictionary["price"] = price
        dictionary["updated_at"] = updatedAt
        return dictionary
    }
    
}
