//
//  CollectionGridItem.swift
//  ArborID
//
//  Created by Taylan Unal on 12/12/20.
//

import SwiftUI

// MARK: -- CollectionGridItem presents a View of Collection, directing to grid of plants found in that Collection.

struct CollectionGridItem: View {
    var collection : Collection
    
    var body: some View {
        VStack(alignment: .center){
            Image(collection.image) // Pulls stored image for Collection
                .frame(width: 150, height: 160)
                .cornerRadius(10)
                .aspectRatio(contentMode: .fit)
            // Next, replace the fixed URL with the url found in the plant object. Clean up the arboretumData.json to handle.
            
            Text("\(collection.name)")
                .frame(width: 120, height: 60)
                .font(.title)
                .fixedSize()
                .multilineTextAlignment(.center)
                .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                .allowsTightening(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .minimumScaleFactor(0.5)
        }
    }
}
