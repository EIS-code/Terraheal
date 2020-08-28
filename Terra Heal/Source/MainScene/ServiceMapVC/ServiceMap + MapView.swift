//
//  ServiceMap + MapView.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 08/07/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension ServiceMapVC :GMSMapViewDelegate {
    
    func setupMapView(mapView: GMSMapView) {
        mapView.delegate = self;
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        mapView.padding = UIEdgeInsets.init(top: 20, left: 20, bottom: vwService.frame.height, right: 20)
        mapView.animate(toLocation: appSingleton.getCurrentCoordinate())
        mapView.animate(toZoom: 15)
        self.mapView.setCurrentMarker(marker: self.currentMarker!, location: appSingleton.getCurrentCoordinate())
        self.mapView.applyStyle()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        mapView.updateLine(polyline: path)
    }
    
    func createNewCenterMarkers() {
        self.removeAllCenterMarker()
        for i  in 0..<arrForServices.count {
            let center: ServiceCenterDetail = self.arrForServices[i]
            let marker:GMSMarker = GMSMarker.init(position: center.getCoordinatte())
            marker.title  = center.name
            marker.map = self.mapView
            marker.userData = i
            self.arrForServicesMarker.append(GMSMarker.init(position: center.getCoordinatte()))
            self.mapView.setMassageCenterMarker(marker: marker, image: UIImage.init(named: "asset-center-maker")!, location: center.getCoordinatte())
        }
    }
    
    func removeAllCenterMarker() {
        for marker in self.arrForServicesMarker {
            marker.map = nil
        }
        self.arrForServicesMarker.removeAll()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let index = marker.userData as? Int {
            self.currentIndex = index
            self.setCenterDataFor(index: self.currentIndex)
        }
        return true
    }
}
