import UIKit

class PropertyDetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var property: Property!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let property = property {
            price.text = "$" + property.price
            address.numberOfLines = 0
            address.text = addressFormatter(forAddress: property.address)
            image.image = UIImage(named: property.imageName)
        } else {
            navigateBack()
        }
    }
    
    // Navigate to the previous view
    private func navigateBack(){
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    // Format the address by splitting ","
    private func addressFormatter(forAddress address: String) -> String {
        let items = address.split(separator: ",")
        let formattedAddress = items.joined(separator: "\n")
        return formattedAddress
    }
}
