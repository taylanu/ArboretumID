//
//  PlantDetailView.swift
//  ArborID
//
//  Created by Taylan Unal on 11/22/20.
//

import SwiftUI

// MARK: Provides a detailed view of the plant selected
// Includes a highlight photo, name, family, genus, species, description.

struct PlantDetailView: View {
    var plant : Plant
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            // Book Details Stack
            VStack(spacing: 20){
                URLImage(url: plant.attributes.image.replacingOccurrences(of: " ", with: "%20"))
                    .frame(width: 320, height: 320, alignment: .center)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 320, height: 100, alignment: .center)
                    Text("\(plant.attributes.commonName)")
                        .frame(width: 320, height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fixedSize()
                        .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                }
                Text("Location: '\(plant.attributes.location)'")
                    .frame(width: 320, height: nil, alignment: .center)
                    .font(.title3)
                Text("Taxon Name: '\(plant.attributes.taxonName)'")
                    .frame(width: 320, height: nil, alignment: .center)
                    .font(.title3)
                Text("Family: \(plant.attributes.family)")
                    .frame(width: 320, height: nil, alignment: .center)
                    .font(.title3)
                Text("Genus: \(plant.attributes.genus)")
                    .frame(width: 320, height: nil, alignment: .center)
                    .font(.title3)
            }
        }
    }
}
