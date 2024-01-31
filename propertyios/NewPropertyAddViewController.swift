//
//  NewPropertyAddViewController.swift
//  propertyios
//
//  Created by user244035 on 1/26/24.
//

import UIKit

protocol AddPropertyDelegate {
    func add(property: Property)
}

class NewPropertyAddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var propertyTypeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    var delegate: AddPropertyDelegate?
    
    let addressPlaceholder = "Enter the address"
    let pricePlaceholder = "Enter the price"
    let propertyTypePlaceholder = "Property Type: House, Unit or Land"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    func setupTextFields() {
        addressTextField.text = addressPlaceholder
        priceTextField.text = pricePlaceholder
        propertyTypeTextField.text = propertyTypePlaceholder
        
        addressTextField.delegate = self
        priceTextField.delegate = self
        propertyTypeTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == addressPlaceholder ||
            textField.text == pricePlaceholder ||
            textField.text == propertyTypePlaceholder {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            switch textField {
            case addressTextField:
                textField.text = addressPlaceholder
            case priceTextField:
                textField.text = pricePlaceholder
            case propertyTypeTextField:
                textField.text = propertyTypePlaceholder
            default:
                break
            }
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        guard let address = addressTextField.text,
              let priceText = priceTextField.text,
              let propertyTypeString = propertyTypeTextField.text else {return}
        guard let propertyType = PropertyType(rawValue: propertyTypeString) else { return}
        
        
        guard let price = Double(priceText) else { return }
                  
        
        let newProperty = Property(address: address, imageName: "new.jpg", thumbnailName: "thumbnail_new.jpg", type: propertyType, price: formatPriceWithCommas(price))
        delegate?.add(property: newProperty)
        dismiss(animated: true)
        print("he")
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
        print("Cancel Tapped")
    }
    
    func formatPriceWithCommas(_ price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
