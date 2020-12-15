//
//  DetailProductViewController.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 14/12/2020.
//

import UIKit

class DetailProductViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var product: Product!
    
    class func newInstance(product: Product) -> DetailProductViewController {
        let detailProductViewController = DetailProductViewController()
        detailProductViewController.product = product
        return detailProductViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockLabel.text = String(product.stock)
        priceLabel.text = "\(String(product.price))€"
        print(product.stock)
        print(product.price)
        imageView.load(url: URL(string: product.imageURL)!)
    }

}
