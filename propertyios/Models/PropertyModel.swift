//
//  PropertyModel.swift
//  propertyios
//
//  Created by user244035 on 1/14/24.
//

import Foundation

class PropertyModel {
    var properties: [Property] = []	
   var jsondata = "properties"
    var file_extension = "json"
    
    init() {
        if let url = Bundle.main.url(forResource: jsondata, withExtension: file_extension){
            do {	
                let data = try Data(contentsOf: url)
                properties = try JSONDecoder().decode([Property].self, from: data)
            } catch {
                    print(error)
            }
        }else{
            print("URL Not working")
            if let path = Bundle.main.path(forResource: jsondata, ofType: file_extension) {
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
    
    func add(property: Property) {
        properties.append(property)
    }
}
