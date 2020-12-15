//
//  ProductListViewController.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 10/12/2020.
//

import UIKit

class ProductListViewController: UIViewController {
    
    enum Identifier: String {
        case store
    }
    
    @IBOutlet weak var tableView: UITableView!
    var store: Store!
    
    class func newInstance(store: Store) -> ProductListViewController {
        let productListViewController = ProductListViewController()
        productListViewController.store = store
        return productListViewController
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = store.name
        let cellNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: Identifier.store.rawValue)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension ProductListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.store.product[indexPath.row]
        let detail = DetailProductViewController.newInstance(product: product)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.store.rawValue, for: indexPath) as! ProductTableViewCell
        let product = store.product[indexPath.row]
        cell.imageViewTab.load(url: URL(string: product.imageURL)!)
        cell.nameLabel.text = product.name
        cell.priceLabel.text = "\(String(product.price))€"
        if product.stock == 0 {
            cell.nameLabel.textColor = .red
        }
        else if product.stock <= 3 {
            cell.nameLabel.textColor = .orange
        }
        else {
            cell.nameLabel.textColor = .green
        }
        return cell
    }
    
    
}
