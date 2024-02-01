import UIKit

class PropertyFavouritesViewController: UIViewController {
    
    
    @IBOutlet weak var favouriteTable: UITableView!
    var model = PropertyModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteTable.dataSource = self
        favouriteTable.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteTable.reloadData()
    }
}

extension PropertyFavouritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteTableCell", for: indexPath)
        let property = model.favourites[indexPath.row]
        cell.textLabel?.text = property.type.rawValue
        cell.detailTextLabel?.text = property.address
        cell.imageView?.image = UIImage(named: property.thumbnailName)
        return cell
    }
}

extension PropertyFavouritesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension PropertyFavouritesViewController: AddToFavouriteDelegate{
    func makeFavourite(property: Property) {
        model.addToFavourite(property: property)
        favouriteTable.reloadData()
    }
}
