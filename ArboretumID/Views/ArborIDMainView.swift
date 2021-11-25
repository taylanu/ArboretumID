//
//  ArborIDMainView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/20/20.
//

import SwiftUI

// MARK: ArborID Main View provides the presentation
struct ArborIDMainView: View {
    @EnvironmentObject var _plantManager : PlantManager
    @EnvironmentObject var _locationManager : LocationManager
    @State private var selectedTab = 0;
    
    var body: some View {
        TabView (selection: $selectedTab){
            HomeView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            
            //            CollectionGridView()
            CollectionHomeView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("Explore")
                }.tag(1)
            
//            EmptyView().font(.system(size: 30, weight: .bold, design: .rounded))
//                .tabItem {
//                    Image(systemName: "camera.viewfinder")
//                    Text("Capture")
//                }.tag(2)
            
            CaptureView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "camera.viewfinder")
                    Text("Capture")
                }.tag(2)
            
            ArboretumMapView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Around Me")
                }.tag(3)
            
            PreferencesView()
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(4)
        }
    }
}
