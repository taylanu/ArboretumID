//
//  CollectionGridView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/20/20.
//

import SwiftUI

// MARK: Provides users a Gridview to Explore the Collections at the Arboretum
// Gridview of plants found at the Arboretum

struct CollectionGridView: View {
    var collection : Collection
    
    let column = [GridItem(.flexible(minimum: 150, maximum: 150)),
                  GridItem(.flexible(minimum: 150, maximum: 150))]
    
    var body: some View {
        ScrollView(.vertical){
//            Section(header:Text(collection.name)){
                LazyVGrid(columns: column, alignment: .center, spacing: 20){
                    ForEach(collection.items.indices, id: \.self){ index in
                        NavigationLink(destination: PlantDetailView(plant: collection.items[index])){
                            PlantGridItem(plant: collection.items[index])
                        }
                    }
                }
//            }
        }.navigationBarTitle(collection.name)
//        .navigationBarBackButtonHidden(true)
    }
}

