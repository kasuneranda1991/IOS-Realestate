import UIKit

// Protocol to handle property addition to favorites
protocol AddToFavouriteDelegate {
    func makeFavourite(property: Property)
}

class PropertyListViewController: UIViewController {
    
    @IBOutlet weak var propertyTable: UITableView!
    
    var model = PropertyModel.shared
    var selectedType: PropertyType?
    
    var delegate: AddToFavouriteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        propertyTable.dataSource = self
        propertyTable.delegate = self
        setupTapGesture()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Handle the preparation for segues
        if segue.identifier == "showPropertyDetailsSeg" {
            if let destinationVC = segue.destination as? PropertyDetailsViewController {
                if let data = sender as? Property {
                    destinationVC.property = data
                }
            }
        } else if segue.identifier == "addPropertySeg"{
            let navVC = segue.destination as? UINavigationController
            let addVC = navVC?.viewControllers.first as? NewPropertyAddViewController
            addVC?.delegate = self
        }
    }
    
    func setupTapGesture() {
        // Set up tap gestures for single and double tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        propertyTable.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        propertyTable.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // Handle single tap on property cell
        if gesture.state == .ended {
            print("Single Tap occured")
            if let indexPath = propertyTable.indexPathForRow(at: gesture.location(in: propertyTable)) {
                let property = model.properties(forType: selectedType)[indexPath.row]
                print(property)
                performSegue(withIdentifier: "showPropertyDetailsSeg", sender: property)
            }
        }
    }
    
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        // Handle double tap on property cell
        if gesture.state == .ended {
            if let indexPath = propertyTable.indexPathForRow(at: gesture.location(in: propertyTable)) {
                let property = model.properties(forType: selectedType)[indexPath.row]
                model.addToFavourite(property: property)
                delegate?.makeFavourite(property: property)
                print("Double tap detected on cell")
                print(model.favourites)
            }
        }
    }
    
    @IBAction func onFIlterChange(_ sender: UISegmentedControl) {
        // Handle filter change based on segment control
        switch sender.selectedSegmentIndex {
        case 0:
            selectedType = nil
        case 1:
            selectedType = .House
        case 2:
            selectedType = .Unit
        case 3:
            selectedType = .Land
        default:
            break
        }
        propertyTable.reloadData()
        print("Filter changed")
    }
}

// MARK: - Table View Data Source
extension PropertyListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.properties(forType: selectedType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the property cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
        let property = model.properties(forType: selectedType)[indexPath.row]
        cell.textLabel?.text = property.type.rawValue
        cell.detailTextLabel?.text = property.address
        cell.imageView?.image = UIImage(named: property.thumbnailName)
        return cell
    }
}

// MARK: - Table View Delegate
extension PropertyListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the selected row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Add Property Delegate
extension PropertyListViewController: AddPropertyDelegate{
    func add(property: Property) {
        // Handle property addition
        model.add(property: property)
        propertyTable.reloadData()
    }
}
