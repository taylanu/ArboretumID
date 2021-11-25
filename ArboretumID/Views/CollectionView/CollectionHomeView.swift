//
//  CollectionHomeView.swift
//  ArborID
//
//  Created by Taylan Unal on 12/11/20.
//

import SwiftUI

// MARK: -- Provides grid of Collections at the Arboretum, with NavigationLinks to each GridView, loaded dynamically.

struct CollectionHomeView: View {
    @EnvironmentObject var plantManager : PlantManager
    
    let column = [GridItem(.flexible(minimum: 150, maximum: 150)),
                  GridItem(.flexible(minimum: 150, maximum: 150))]
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                LazyVGrid(columns: column, alignment: .center, spacing: 20){
                    ForEach(plantManager.collections.indices, id: \.self){ index in
                        NavigationLink(destination: CollectionGridView(collection: plantManager.collections[index])){
                            CollectionGridItem(collection: plantManager.collections[index])
                        }
                    }
                }
            }.navigationBarTitle("Collections")
            .navigationBarBackButtonHidden(true)
        }
    }
}
