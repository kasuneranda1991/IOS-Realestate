//
//  PropertyModel.swift
//  propertyios
//
//  Created by user244035 on 1/14/24.
//

import Foundation

class PropertyModel {
    var properties: [Property] = []
 var jsondata = "Resources/properties"
    //var jsondata = "properties"
    
    init() {
        if let url = Bundle.main.url(forResource: jsondata, withExtension: "json", subdirectory: "Resources"){
            print(url)
            do {
                let data = try Data(contentsOf: url)
                 properties = try JSONDecoder().decode([Property].self, from: data)
                print(properties)
            } catch {	
                    print(error)
            }
        }else{
            print("URL Not working")
            if let path = Bundle.main.path(forResource: jsondata, ofType: "json") {
                print("File exists at path: \(path)")
            } else {
                print("File not found.")
            }
            
        }
    }
    
    func properties(forType type: PropertyType?) -> [Property] {
        guard let type = type else {return properties}
        return properties.filter{$0.type == type}
    }
}
