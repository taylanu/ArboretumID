//
//  PreferencesView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/21/20.
//

import SwiftUI

// MARK: PreferencesView allows users to Sign In with Apple to Save their Favorites, configure preferences.

struct PreferencesView: View {
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Location Access")){ // Allows User to pick what Collections to View
                    Toggle(isOn: $locationManager.showsUserLocation, label: {
                        Text("Show Current Location").font(.body)
                    })
                }
            }.navigationBarTitle("Preferences")
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    @State var locationManager = true
    static var previews: some View {
        PreferencesView()
    }
}
