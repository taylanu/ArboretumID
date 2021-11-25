//
//  PlantManager.swift
//  ArborID
//
//  Created by Taylan Unal on 11/21/20.
//

import SwiftUI

// MARK: PlantManager provides the Data Model for Plants found at the Arboretum
// Uses data from arboretumData.json to populate Plant Model using Codable/Decodable

struct Collection : Identifiable {
    let id : UUID
    let name : String // Collection Name
    let image : String // Collection Image
    let items : [Plant] // Plants found in the collection
}

class PlantManager : ObservableObject {
    private let destinationURL : URL
    @Published var plants : [Plant] // all plants
    
    @Published var childrensGarden : [Plant] = []
    @Published var eventLawn : [Plant] = []
    @Published var fountainGarden : [Plant] = []
    @Published var marshMeadow : [Plant] = []
    @Published var northTerrace : [Plant] = []
    @Published var overlookPavillion : [Plant] = []
    @Published var oasisGarden : [Plant] = []
    @Published var pollinatorsGarden : [Plant] = []
    @Published var roseFragranceGarden : [Plant] = []
    @Published var strollingGarden : [Plant] = []
    @Published var parkingLot : [Plant] = []
    
    @Published var collections : [Collection] = []
    @Published var selectedCollection : Int = 0
    

    init(){
        let filename = "arboretumData" // Derived from GeoJSON file from Arboretum ARCGIS
        let bundleURL = Bundle.main.url(forResource: filename, withExtension: "json")!
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        destinationURL = documentURL.appendingPathComponent(filename + ".json")
        let fileExists = fileManager.fileExists(atPath: destinationURL.path) //cast
        
        do {
            let url = fileExists ? destinationURL : bundleURL
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            plants = try decoder.decode([Plant].self, from: data)
        } catch   {
            print("Error decoding Plants: \(error)")
            plants = []
        }
        
        // MARK: -- Sort all Plants by Name
        plants = plants.sorted(by: {$0.attributes.commonName < $1.attributes.commonName})
        
        // MARK: - Filtering Plants into Collection Arrays
        childrensGarden = plants.filter({$0.attributes.location.contains("Children's Garden")})
        eventLawn = plants.filter({$0.attributes.location.contains("Event Lawn")})
        fountainGarden = plants.filter({$0.attributes.location.contains("Fountain Garden")})
        marshMeadow = plants.filter({$0.attributes.location.contains("Marsh Meadow")})
        northTerrace = plants.filter({$0.attributes.location.contains("North Terrace")})
        overlookPavillion = plants.filter({$0.attributes.location.contains("Overlook Pavilion")})
        oasisGarden = plants.filter({$0.attributes.location.contains("Oasis Garden")})
        pollinatorsGarden = plants.filter({$0.attributes.location.contains("Pollinator's Garden")}) //No Plants yet, still being built!
        roseFragranceGarden = plants.filter({$0.attributes.location.contains("Rose and Fragrance")})
        strollingGarden = plants.filter({$0.attributes.location.contains("Strolling Garden")})
        parkingLot = plants.filter({$0.attributes.location.contains("Parking Lot")})
        
        // MARK: - Build Collections Array from Filtered Plant Arrays
        collections.append(Collection.init(id: UUID(), name: "All Plants", image: "PlantImage", items: plants))
        collections.append(Collection.init(id: UUID(), name: "Childrens Garden", image: "ChildrensGarden", items: childrensGarden))
        collections.append(Collection.init(id: UUID(), name: "Event Lawn", image: "EventLawn", items: eventLawn))
        collections.append(Collection.init(id: UUID(), name: "Fountain Garden", image: "FountainGarden", items: fountainGarden))
        collections.append(Collection.init(id: UUID(), name: "Marsh Meadow", image: "MarshMeadow", items: marshMeadow))
        collections.append(Collection.init(id: UUID(), name: "North Terrace", image: "NorthTerrace", items: northTerrace))
        collections.append(Collection.init(id: UUID(), name: "Overlook Pavilion", image: "OverlookPavilion", items: overlookPavillion))
        collections.append(Collection.init(id: UUID(), name: "Oasis Garden", image: "OasisGarden", items: oasisGarden))
        collections.append(Collection.init(id: UUID(), name: "Pollinators Garden", image: "PollinatorGarden", items: pollinatorsGarden))
        collections.append(Collection.init(id: UUID(), name: "Rose & Fragrance", image: "RoseFragrance", items: roseFragranceGarden))
        collections.append(Collection.init(id: UUID(), name: "Strolling Garden", image: "StrollingGarden", items: strollingGarden))
        collections.append(Collection.init(id: UUID(), name: "Parking Lot", image: "ParkingLot", items: parkingLot))
    }  
    
    //MARK: - Save Data
    // Saves changes made to plant data, encoding it to JSON
    func saveData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(plants)
            try data.write(to: destinationURL)
        } catch {
            print("Error writing data")
        }
    }
}
