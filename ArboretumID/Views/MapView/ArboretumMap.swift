//
//  ArboretumMap.swift
//  ArborID
//
//  Created by Taylan Unal on 11/22/20.
//

import SwiftUI
import MapKit

// MARK: Displays a SwiftUI Map of Arboretum using Apple Maps with Annotations of all Plants in Collections at Arboretum

struct ArboretumMap: View {
    @EnvironmentObject var plantManager : PlantManager
    @EnvironmentObject var locationManager : LocationManager
    @State var userTrackingMode : MapUserTrackingMode = .none // either follow or none.
    @State var showUserLocation : Bool = false
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $locationManager.region,
                interactionModes: .all,
                showsUserLocation: showUserLocation,
                userTrackingMode: .none,
                annotationItems: plantManager.collections[plantManager.selectedCollection].items,
                annotationContent: annotationPins)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        resetMapCoordinates
                    }
                    ToolbarItem(placement: .navigationBarLeading){
                        resetToUserLocation
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        toggleShowingUserLocation
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        collectionsListButton
                    }
                }.navigationTitle("Arboretum Map")
        }
    }
    
    
    // MARK: -- Map Functions
    
    // Resets Map Center to Arboretum Coordinates
    var resetMapCoordinates : some View { // Reset Map to Arboretum Coordinates
        Button(action: {locationManager.resetMapCoordinates()}) {
            Image(systemName: "house.fill")
        }
    }
    
    // Starts/Stops Updating User Location
    var toggleUpdatingUserLocation : some View {
        Picker("UpdateUserLocation", selection: $showUserLocation) {
            Button(action: {locationManager.locationManager.stopUpdatingLocation()}) {
                Image(systemName: "location.slash.fill")
            }.tag(0)
            Button(action: {locationManager.locationManager.startUpdatingLocation()}) {
                Image(systemName: "location.fill")
            }.tag(1)
        }.frame(width: 130)
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var toggleShowingUserLocation : some View {
        Button(action: {showUserLocation.toggle()}) {
            Image(systemName: "figure.walk.circle.fill")
        }
    }
    
    // Start Updating User Location
    var enableUpdatingUserLocation : some View {
        Button(action: {locationManager.locationManager.startUpdatingLocation()}) {
            Image(systemName: "location.fill")
        }
    }
    
    // Stop Updating User Location
    var disableUpdatingUserLocation : some View {
        Button(action: {locationManager.locationManager.stopUpdatingLocation()}) {
            Image(systemName: "location.slashfill")
        }
    }
    
    // Reset Map Coordinates to Arboretum Coordinates
    var resetToUserLocation : some View {
        Button(action: {locationManager.resetMapCurrentLocation()}) {
            Image(systemName: "location.fill.viewfinder")
        }
    }
    
    // Picker to show annotations from selected Collection
    var collectionsListButton : some View {
        Picker(selection: $plantManager.selectedCollection, label:Image(systemName: "square.stack.3d.down.forward.fill")) {
            ForEach(plantManager.collections.indices, id:\.self) {index in
                HStack{
                    Text(plantManager.collections[index].name)
                }
            }
        }.pickerStyle(MenuPickerStyle())
    }
    
    //MARK: - AnnotationMarkers plots plants on the map with Markers
    func annotationMarkers (item:Plant) -> some MapAnnotationProtocol {
        MapMarker(coordinate: item.attributes.coordinate)
    }
    
    // Used to display pins for all buildings on campus
    func annotationPins (item:Plant) -> some MapAnnotationProtocol {
        MapPin(coordinate: item.attributes.coordinate)
    }
}
