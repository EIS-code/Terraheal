//
//  UserGiveReviewToStore.swift
//  ShoppingApp
//
//  Created by Jaydeep on ""4/11/19.
//  Copyright © 2""19 Jaydeep. All rights reserved.
//

import Foundation

//MARK: Request Models
struct ServiceDetail {
    var id:  String = ""
    var name:  String = ""
    var details:  String = ""
    var duration:  [ServiceDurationDetail] = []
    var isSelected:  Bool = false
    static func getMassageArray() ->  [ServiceDetail] {
        let serviceDetail1 = ServiceDetail(id: "1", name: "head, neck and shoulders massage", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail2 = ServiceDetail(id: "2", name: "hand or foot massage", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail3 = ServiceDetail(id: "3", name: "tok sen - thai massage", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail4 = ServiceDetail(id: "4", name: "thai yoga massage", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail5 = ServiceDetail(id: "5", name: "tok sen - thai massage", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail6 = ServiceDetail(id: "6", name: "thai yoga massage", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        return[serviceDetail1,serviceDetail2,serviceDetail3,serviceDetail4,serviceDetail5,serviceDetail6]
    }
    static func getTherapyArray() ->  [ServiceDetail] {
        let serviceDetail1 = ServiceDetail(id: "1", name: "head, neck and shoulders therapy", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail2 = ServiceDetail(id: "2", name: "hand or foot therapy", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail3 = ServiceDetail(id: "3", name: "tok sen - thai therapy", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail4 = ServiceDetail(id: "4", name: "thai yoga therapy", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail5 = ServiceDetail(id: "5", name: "tok sen - thai therapy", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        let serviceDetail6 = ServiceDetail(id: "6", name: "thai yoga therapy", details: ServiceDetail.getServiceDetail(),duration: ServiceDurationDetail.getDemoArray())
        return[serviceDetail1,serviceDetail2,serviceDetail3,serviceDetail4,serviceDetail5,serviceDetail6]
    }
    static func getServiceDetail() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Bibendum est ultricies integer quis. Iaculis urna id volutpat lacus laoreet. Mauris vitae ultricies leo integer malesuada. Ac odio tempor orci dapibus ultrices in. Egestas diam in arcu cursus euismod. Dictum fusce ut placerat orci nulla. Tincidunt ornare massa eget egestas purus viverra accumsan in nisl. Tempor id eu nisl nunc mi ipsum faucibus. Fusce id velit ut tortor pretium. Massa ultricies mi quis hendrerit dolor magna eget. Nullam eget felis eget nunc lobortis."
    }
}
enum RequestBooking {
    
    struct Create {
        var id: String = PreferenceHelper.shared.getUserId()
        var session: SessionDetail = SessionDetail.init(fromDictionary: [:])
        var serviceType: ServiceType = ServiceType.Massages
        var serviceCenterDetail: ServiceCenterDetail = ServiceCenterDetail.init(servicesList: [])
        var reciepentData: [ReciepentMassageData] = []
        var date: Double = 0.0
        var bookingNotes: String = ""
        
        
    }
    
    
    class Response: ResponseModel {
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
        }
    }
}



