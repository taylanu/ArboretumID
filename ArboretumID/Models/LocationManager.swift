//
//  LocationsManager.swift
//  ArborID
//
//  Created by Taylan Unal on 11/22/20.
//

import SwiftUI
import MapKit

// MARK: -- Provides Location manager data on Arboretum Mapping.
struct ArboretumMapData {
    // Arboretum Coordinates: 40.80604779005312, -77.86848917035263
    static let initialCoordinate = CLLocationCoordinate2D(latitude: 40.806047, longitude: -77.868489)
    static let span : CLLocationDegrees = 0.003
}

// MARK: -- Provides Location Tracking for Map using CLLocationManager
class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager : CLLocationManager
    var showsUserLocation = true
    
    override init() {
        // Initialize Location Manager
        locationManager = CLLocationManager()
        
        super.init()
        
        // Options passed for Location Delegate, Accuracy
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Published Values for Map View
    @Published var region = MKCoordinateRegion(center: ArboretumMapData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: ArboretumMapData.span, longitudeDelta: ArboretumMapData.span))
    
    //MARK: - LOCATION DELEGATE
    // Check if Location Access is Allowed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
//            locationManager.startUpdatingLocation() //temporarily disabled.
            locationManager.stopUpdatingLocation()
            showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newCoordinates = locations.map {$0.coordinate}
        if let coordinate = newCoordinates.first {
            region.center = coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("CLLocationManager Failed")
    }
    
    // MARK: -- Map Functions
    func resetMapCoordinates(){
        region = MKCoordinateRegion(center: ArboretumMapData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: ArboretumMapData.span, longitudeDelta: ArboretumMapData.span))
    }
    
    func resetMapCurrentLocation(){
        region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? ArboretumMapData.initialCoordinate, span: MKCoordinateSpan(latitudeDelta: ArboretumMapData.span, longitudeDelta: ArboretumMapData.span))
    }
    
    // MARK: -- Experimental Function, toggling Location Tracking from Map.
//    func toggleUpdatingUserLocation(){
//        if(isUpdatingUserLocation){
//            locationManager.startUpdatingLocation()
//        } else{
//            locationManager.stopUpdatingLocation()
//        }
//    }
    
}


