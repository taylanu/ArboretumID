//
//  PlantGridItem.swift
//  ArborID
//
//  Created by Taylan Unal on 11/22/20.
//

import SwiftUI

struct PlantGridItem: View {
    var plant : Plant
    
    var body: some View {
        VStack(alignment: .center){
            if plant.attributes.image.contains("Image_Coming_Soon.jpg"){
                Image("ImageComingSoon") // Decided not to remotely load image not available.
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fill)
            } else{
                URLImage(url: plant.attributes.image.replacingOccurrences(of: " ", with: "%20")) // Adds %20 instead of spaces in URL to make it valid. Ex: https://maps.psiee.psu.edu/PSU_ARB/px/Abelia%20x%20grandiflora_2%20(479).jpg
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
            }
            // Next, replace the fixed URL with the url found in the plant object. Clean up the arboretumData.json to handle.
            
            Text("\(plant.attributes.commonName)")
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
