//
//  PropertyDetailsViewController.swift
//  propertyios
//
//  Created by user244035 on 1/26/24.
//

import UIKit

class PropertyDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var property: Property!
    override func viewDidLoad() {
        super.viewDidLoad()
        price.text = "$"+property.price
        address.numberOfLines = 0
        address.text = addressFormatter(forAddress: property.address)
        image.image = UIImage(named: property.imageName)
    }

    private func addressFormatter(forAddress address: String) -> String {
        let items = address.split(separator: ",")
        let formattedAddress = items.joined(separator: "\n")
        return formattedAddress
    }
}
