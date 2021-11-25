//
//  Plant.swift
//  ArborID
//
//  Created by Taylan Unal on 11/22/20.
//

import SwiftUI
import MapKit

// MARK: Plant provides the fundamentatal data required to display a Plant found at the Arboretum
// EAch plant has an "Attributes" object, so need to decode that JSON

struct Plant : Identifiable, Codable { // Each plant has features, each feature has properties. Those properties contain the relevant details for the plant.
    let id : UUID
    let attributes : Attributes
    
    private enum CodingKeys: String, CodingKey {
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        attributes = try values.decode(Attributes.self, forKey: .attributes)
    }
}

struct Attributes : Codable {
    let plantID : Int
    let year : String // JSON defines year as "2016" instead of Int
    let latitude : Double // use ItemCoordX
    let longitude : Double // use ItemCoordY
    let family : String
    let genus : String
    let taxonName : String
    let commonName : String
    let location : String // Defined as the garden where the plant exists
    var image : String // Defined as a HTML snippet. Need to extract only URL.
    
    // Custom Attributes for Annotations
    var placemark : MKPlacemark
    var coordinate : CLLocationCoordinate2D
    
    private enum CodingKeys: String, CodingKey {
        case plantID = "OBJECTID_12"
        case year = "AccYear"
        case latitude = "ItemCoordX"
        case longitude = "ItemCoordY"
        case family = "Family"
        case genus = "Genus"
        case taxonName = "Taxon_Name"
        case commonName = "Common_Nam"
        case location = "Location"
        case image = "Picture"
    }
    
    // MARK: Initialize Attributes Decoding
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // These Attributes guaranteed to exist, using decode.
        plantID = try values.decode(Int.self, forKey: .plantID)
        year = try values.decode(String.self, forKey: .year)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        family = try values.decode(String.self, forKey: .family)
        genus = try values.decode(String.self, forKey: .genus)
        taxonName = try values.decode(String.self, forKey: .taxonName)
        commonName = try values.decode(String.self, forKey: .commonName)
        location = try values.decode(String.self, forKey: .location)
        image = try values.decode(String.self, forKey: .image)
        
        image = image.replacingOccurrences(of: " ", with: "%20") // Makes URL's parsable by URL Handler.
        
        // MARK: -- Custom Variables defining Coordinate and Placemark for Annotations.
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        placemark = MKPlacemark(coordinate: coordinate)
    }
}
