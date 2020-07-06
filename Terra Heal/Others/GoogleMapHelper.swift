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
import GoogleMaps
extension GMSMapView {
        
    func setMarker(marker:GMSMarker) {
        if marker.map == nil {
            marker.map = self
        }
    }
    func drawPolyline(source:CLLocationCoordinate2D,destination:CLLocationCoordinate2D) {
        let dotPath :GMSMutablePath = GMSMutablePath()
        // add coordinate to your path
       
    }
    
}

