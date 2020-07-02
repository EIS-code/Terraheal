//
//  Common.swift
//  EserviceProvider
//  Created by Mac Pro5 on 01/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit
import QuartzCore
import CoreLocation
import GooglePlaces


typealias LC = LocationCenter

class LocationCenter: NSObject, CLLocationManagerDelegate {
    
    let manager: CLLocationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var myLatitude:String = ""
    var myLongitude:String = ""
    var myAddress:String = ""
    var my:String = ""
    
    class var isServicesEnabled: Bool {
        get {
            return CLLocationManager.locationServicesEnabled()
        }
    }
    
    class var authorizationStatus: CLAuthorizationStatus {
        get {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    var lastLocation: CLLocation? {
        get {
            return self.manager.location
        }
    }
    
    static let `default`: LocationCenter = {
        let instance: LocationCenter = LocationCenter()
        return instance
    }()
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.activityType = CLActivityType.other
        self.manager.distanceFilter = kCLDistanceFilterNone
        self.manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.manager.pausesLocationUpdatesAutomatically = true
        self.requestAuthorization()
        //self.manager.allowsBackgroundLocationUpdates = true
        //self.manager.showsBackgroundLocationIndicator = false
    }
    
    deinit {
        //debugPrint("\(self) \(#function)")
    }
    
    func requestAuthorization() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    func requestLocationOnce() {
        self.manager.requestLocation()
        self.start()
    }
    
    func start() {
        self.manager.startUpdatingLocation()
    }
    
    func stop() {
        self.manager.stopUpdatingLocation()
    }
    
    // MARK: - LocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.notDetermined:
            debugPrint("\(self) \(#function) notDetermined")
            self.stop()
            break
        case CLAuthorizationStatus.restricted:
            debugPrint("\(self) \(#function) restricted")
            self.stop()
            break
        case CLAuthorizationStatus.denied:
            debugPrint("\(self) \(#function) denied")
            self.stop()
            break
        case CLAuthorizationStatus.authorizedAlways:
            debugPrint("\(self) \(#function) authorizedAlways")
            self.start()
            break
        case CLAuthorizationStatus.authorizedWhenInUse:
            debugPrint("\(self) \(#function) authorizedWhenInUse")
            self.start()
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        debugPrint("\(self) \(#function)")
        guard let mostRecentLocation = locations.last else { return }
        Common.nCd.post(name: Common.locationUpdateNtfNm,
                        object: self,
                        userInfo: ["ncd": ["location": mostRecentLocation]])
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        debugPrint("\(self) \(#function)")
        Common.nCd.post(name: Common.locationFailNtfNm,
                        object: self,
                        userInfo: ["ncd": ["locationError": error]])
        
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFinishDeferredUpdatesWithError error: Error?) {
        debugPrint("\(self) \(#function)")
        
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        debugPrint("\(self) \(#function)")
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        debugPrint("\(self) \(#function)")
    }
    
    func getAddressFromGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        if geocoder.isGeocoding {
            geocoder.cancelGeocode()
        }
        geocoder.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude), preferredLocale: .current) { (placemarks, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else  {
                if let placeMark = placemarks?.last {
                    print(placeMark.addressDictionary)
                }
            }
        }
        
    }
}

extension LocationCenter {
    
    
    
    func getAddressFromCoordinate(coordinate:CLLocationCoordinate2D, completion : @escaping ((Address) -> Void))
    {
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude:coordinate.longitude)) { (places, error) in
            
            let address:Address = Address.init(fromDictionary: [:])
            if error == nil{
                if let place = places?.first {
                    
                    address.addressLine1 = place.thoroughfare ?? ""
                    address.addressLine2 = place.subThoroughfare ?? ""
                    address.city = place.locality ?? ""
                    address.name = place.name ?? ""
                    address.landMark = place.subLocality ?? ""
                    address.latitude = place.location?.coordinate.latitude.toString(places: 8) ?? ""
                    address.longitude = place.location?.coordinate.longitude.toString(places: 8) ?? ""
                    address.pinCode = place.postalCode ?? ""
                    address.province = place.administrativeArea ?? ""
                    print(address.toDictionary())
                    completion(address)
                    //here you can get all the info by combining that you can make address
                } else {
                    completion(address)
                }
            }  else {
                completion(address)
            }
        }
    }
    
    func getAutocomplete(text:String, completion: @escaping  (([AutoCompleteAddress]) -> Void)) {
        let token = GMSAutocompleteSessionToken.init()
        
        // Create a type filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        let placeClient = GMSPlacesClient.shared()
        placeClient.findAutocompletePredictions(fromQuery: text, bounds: nil, boundsMode: .bias, filter: filter, sessionToken: token) { (results, error) in
            var arrForAutoComplete: [AutoCompleteAddress] = []
            if let error = error {
                print("Autocomplete error: \(error)")
                completion(arrForAutoComplete)
                return
            }
            if let results = results {
                for result in results {
                    arrForAutoComplete.append(AutoCompleteAddress.init(title: result.attributedPrimaryText, subTitle:result.attributedFullText, placeID: result.placeID))
                    completion(arrForAutoComplete)
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                }
            } else {
                completion(arrForAutoComplete)
            }
        }
        
    }
    /*
     func getAddressFromLatitudeLongitude(latitude:Double,longitude:Double) -> (String,[Double]) {
     let strURL:String = "\(Google.GEOCODE_URL)\(Google.LAT_LNG)=\(latitude),\(longitude)&\(Google.KEY)=\(preferenceHelper.getGoogleKey())"
     let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
     guard let url = URL(string: urlStr) else {
     return ("",[0.0,0.0])
     }
     do{
     let data = try Data(contentsOf: url)
     let jsonObject:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
     if ((jsonObject[Google.STATUS] as! String) == Google.OK)
     {
     
     let resultObject:[String:Any] = ((jsonObject[Google.RESULTS] as! NSArray)[0] as! [String:Any])
     
     let address:String = (resultObject[Google.FORMATTED_ADDRESS] as? String) ?? ""
     let geometryObject:[String:Any] = resultObject[Google.GEOMETRY] as! [String:Any];
     
     let location = [((geometryObject[Google.LOCATION] as! [String:Any])[Google.LAT] as? Double) ?? 0.0, ((geometryObject[Google.LOCATION] as! [String:Any])[Google.LNG] as? Double) ?? 0.0]
     
     return (address,location)
     }
     return ("",[0.0,0.0])
     
     }
     catch let error as NSError
     {
     print(error)
     return ("",[0.0,0.0])
     }
     }
     
     func getLatLongFromAddress(address:String) -> [Double]
     {
     
     if address.isEmpty()
     {
     return [0.0,0.0]
     }
     else
     {
     let strURL:String = "\(Google.GEOCODE_URL)\(Google.ADDRESS)=\(address)&\(Google.KEY)=\(Google.API_KEY)"
     
     let urlStr : String = strURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
     
     
     guard let url = URL(string: urlStr)
     else
     {
     return [0.0,0.0]
     }
     
     do{
     let data = try Data(contentsOf: url)
     let jsonObject:[String:Any] = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
     if ((jsonObject[Google.STATUS] as! String) == Google.OK)
     {
     
     let resultObject:[String:Any] = ((jsonObject[Google.RESULTS] as! NSArray)[0] as! [String:Any])
     
     let geometryObject:[String:Any] = resultObject[Google.GEOMETRY] as! [String:Any];
     
     let latitude = ((geometryObject[Google.LOCATION] as! [String:Any])[Google.LAT] as? Double) ?? 0.0
     
     let longitude =
     ((geometryObject[Google.LOCATION] as! [String:Any])[Google.LNG] as? Double) ?? 0.0
     return [latitude,longitude]
     }
     return [0.0,0.0]
     }
     catch _ as NSError
     {
     return [0.0,0.0]
     }
     
     }
     } */
    
}

