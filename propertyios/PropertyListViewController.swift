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
        setupTapGesture()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        propertyTable.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        propertyTable.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
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
        if gesture.state == .ended {
            if let indexPath = propertyTable.indexPathForRow(at: gesture.location(in: propertyTable)) {
                print("Double tap detected on cell at row \(indexPath.row)")
            }
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
