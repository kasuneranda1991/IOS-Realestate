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
    
    // Handle placeholders in input text fields
    func setupTextFields() {
        addressTextField.text = addressPlaceholder
        priceTextField.text = pricePlaceholder
        propertyTypeTextField.text = propertyTypePlaceholder
        
        addressTextField.delegate = self
        priceTextField.delegate = self
        propertyTypeTextField.delegate = self
    }
    
    // remove placeholder once start edition
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == addressPlaceholder ||
            textField.text == pricePlaceholder ||
            textField.text == propertyTypePlaceholder {
            textField.text = ""
        }
    }
    
    // reassign placeholder if text field is empty
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
    
    // show validation message to user
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func didTapSave(_ sender: Any) {
        // Validate input fields
        guard let address = addressTextField.text, !address.isEmpty, address != addressPlaceholder else {
            showAlert(message: "Please enter a valid address.")
            return
        }
        
        guard let propertyTypeString = propertyTypeTextField.text, let propertyType = PropertyType(rawValue: propertyTypeString) else {
            showAlert(message: "Please select a valid property type.")
            return
        }
	
        
        guard let priceText = priceTextField.text, let price = Double(priceText), price > 0 else {
            showAlert(message: "Please enter a valid price.")
            return
        }
        
        // create new property and add it to the data array
        let newProperty = Property(address: address, imageName: "new.jpg", thumbnailName: "thumbnail_new.jpg", type: propertyType, price: formatPriceWithCommas(price))
        delegate?.add(property: newProperty)
        dismiss(animated: true)
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true)
        print("Cancel Tapped")
    }
    
    // format user property price
    func formatPriceWithCommas(_ price: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: price)) ?? ""
    }
}
