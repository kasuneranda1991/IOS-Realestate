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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onFIlterChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedType = nil
        case 1:
            selectedType = .House
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
        cell.textLabel?.text = property.address
        cell.detailTextLabel?.text = property.imageName
        cell.imageView?.image = UIImage(named: property.thumbnailName)
        return cell
    }
    
    
}
