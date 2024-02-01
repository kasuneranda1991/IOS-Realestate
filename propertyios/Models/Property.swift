//
//  Property.swift
//  propertyios
//
//  Created by user244035 on 1/14/24.
//

import Foundation

// A struct representing a property, conforming to the Decodable protocol for decoding from JSON
struct Property: Decodable {
    var address: String       // The address of the property
    var imageName: String     // The name of the image associated with the property
    var thumbnailName: String // The name of the thumbnail image associated with the property
    var type: PropertyType     // The type of the property (House, Unit, Land)
    var price: String         // The price of the property
}

// An enumeration defining possible property types, conforming to the Decodable protocol
enum PropertyType: String, Decodable {
    case House = "House"  // A residential house property type
    case Unit = "Unit"    // A residential unit property type
    case Land = "Land"    // A land property type
}
