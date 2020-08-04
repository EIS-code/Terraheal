//
//  Singleton.swift
//  ShoppingApp
//
//  Created by Jaydeep on 05/11/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import CoreLocation
let appSingleton = Singleton.shared

public class Singleton :NSObject {
    static let shared = Singleton()
    var user:User.UserData = User.UserData.init(fromDictionary: [:])
    var myMassagePreference: MyMassagePreference = MyMassagePreference.init()
    var myLatitude: String = ""
    var myLongitude: String = ""
    var myAddress: String = ""
    var massagePrefrenceDetail:[MassagePreferenceDetail] = []
    var myBookingData: MyBookingData = MyBookingData.init()
    
    
    func getPressureDetail() -> MassagePreferenceDetail? {
        for data in massagePrefrenceDetail {
            if data.id == MassagePreferenceMenu.Pressure.rawValue {
                return data
            }
        }
        return nil
    }
    
    func getPreferedGender() -> MassagePreferenceDetail? {
        for data in massagePrefrenceDetail {
            if data.id == MassagePreferenceMenu.GenderPreference.rawValue {
                return data
            }
        }
        return nil
    }
    
    private override init() {

    }
    func clear() {

    }

    func getCurrentCoordinate()-> CLLocationCoordinate2D {
        return CLLocationCoordinate2D.init(latitude: self.myLatitude.toDouble, longitude: self.myLongitude.toDouble)
    }
    class func saveInDb() {
        if let encoded = try? JSONEncoder().encode(appSingleton.user) {
            UserDefaults.standard.set(encoded, forKey: "kUser")
        }
    }
    class func loadFrombDB() {
        guard let savedPersonData = UserDefaults.standard.object(forKey: "kUser") as? Data else { return }
        guard let savedPerson = try? JSONDecoder().decode(User.UserData.self, from: savedPersonData) else { return }
        appSingleton.user = savedPerson
    }
}

class MyMassagePreference: NSObject {
    override init() {
        super.init()
    }

    var pressure:  PreferenceOption = PreferenceOption.init(fromDictionary: [:])
    var prefereGender: PreferGender = .NoPreference
    var treatmentDescription: String = ""
    var problemsDescription: String = ""
    var pastSurgeryDescription: String = ""
    var allergiesDescription: String = ""
    var healthConditionDescription: String = ""
    
}

