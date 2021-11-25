//
//  ArboretumMapView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/20/20.
//

import SwiftUI
import MapKit

// MARK: Provides Map with Annotations of Plants in the Area

struct ArboretumMapView: View {
    @ObservedObject var locationManager = LocationManager()
    @State var manager = CLLocationManager()   
    
    var body: some View {
        NavigationView{
            ZStack{
                // Display Map of Arboretum using Apple Maps
                ArboretumMap()
                    .navigationBarTitleDisplayMode(.inline)
                    .edgesIgnoringSafeArea(.all)
                
                // Display annotations overlay of plants nearby.
                
            }.environmentObject(locationManager)
        }
    }
}
