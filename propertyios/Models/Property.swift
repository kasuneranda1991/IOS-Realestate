//
//  Property.swift
//  propertyios
//
//  Created by user244035 on 1/14/24.
//

import Foundation

struct Property: Decodable {
    var address: String
    var imageName: String
    var thumbnailName: String
    var type: PropertyType
    var price: Int
}

enum PropertyType: String, Decodable {
    case House = "House"
}
