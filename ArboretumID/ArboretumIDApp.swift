//
//  ArboretumIDApp.swift
//  ArboretumID
//
//  Created by Taylan Unal on 11/4/21.
//

import SwiftUI

@main
struct ArboretumIDApp: App {
    var plantManager = PlantManager()
    
    var body: some Scene {
        WindowGroup {
            ArborIDMainView()
                .environmentObject(plantManager)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
