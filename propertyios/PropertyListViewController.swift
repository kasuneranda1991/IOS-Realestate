//
//  PropertyListViewController.swift
//  propertyios
//
//  Created by user244035 on 1/14/24.
//

import UIKit

class PropertyListViewController: UIViewController {

    @IBOutlet weak var propertyTable: UITableView!
    
    var model = PropertyModel()
    var selectedType: PropertyType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        propertyTable.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPropertyDetailsSeg"{
            if let indexPath = propertyTable.indexPathForSelectedRow{
                let property = model.properties[indexPath.row]
                let detailVC = segue.destination as? PropertyDetailsViewController
                detailVC?.property = property
            }
        } else if segue.identifier == "addPropertySeg"{
            let navVC = segue.destination as? UINavigationController
            let addVC = navVC?.viewControllers.first as? NewPropertyAddViewController
            addVC?.delegate = self
        }
    }
    	
    @IBAction func onFIlterChange(_ sender: UISegmentedControl) {
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
        print("FIlter changed")
    }
}

extension PropertyListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.properties(forType: selectedType).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
        let property = model.properties(forType: selectedType)[indexPath.row]
        cell.textLabel?.text = property.type.rawValue
        cell.detailTextLabel?.text = property.address
        cell.imageView?.image = UIImage(named: property.thumbnailName)
        return cell
    }
    
    
}

extension PropertyListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension PropertyListViewController: AddPropertyDelegate{
    func add(property: Property) {
        model.add(property: property)
        propertyTable.reloadData()
    }
}
