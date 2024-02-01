import Foundation
import UIKit

// A class that manages property-related data and operations
class PropertyModel {
    
    static let shared = PropertyModel() // Singleton instance for shared access
    
    var properties: [Property] = []      // Array to store all properties
    var favourites: [Property] = []      // Array to store favourite properties
    var jsondata = "properties"          // JSON file name
    var file_extension = "json"           // JSON file extension
    
    // Initializer to load property data from a JSON file on object creation
    init() {
        if let url = Bundle.main.url(forResource: jsondata, withExtension: file_extension) {
            do {
                let data = try Data(contentsOf: url)
                properties = try JSONDecoder().decode([Property].self, from: data)
            } catch {
                print(error)
            }
        } else {
            print("URL not working")
            if let path = Bundle.main.path(forResource: jsondata, ofType: file_extension) {
                print("File exists at path: \(path)")
            } else {
                print("File not found.")
            }
        }
    }
    
    // Retrieve properties based on the specified type
    func properties(forType type: PropertyType?) -> [Property] {
        guard let type = type else { return properties }
        return properties.filter { $0.type == type }
    }
    
    // Add a new property to the properties array
    func add(property: Property) {
        properties.append(property)
    }
    
    // Add a property to the favourites array, showing an alert based on whether it was added successfully
    func addToFavourite(property: Property) {
        if !favourites.contains(where: { $0.address == property.address }) {
            favourites.append(property)
            showAlert(message: "Success! You have added the \"\(property.address)\" to the favourites.")
        } else {
            showAlert(message: "Info! Property is already in favourites.")
        }
    }
    
    // Show an alert with the given message
    private func showAlert(message: String) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let topViewController = windowScene.windows.first?.rootViewController {
            
            let alertController = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
