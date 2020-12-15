//
//  Product.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 18/11/2020.
//

import Foundation

class Product {
    
    var name: String
    var imageURL: String
    var price: Double
    var stock: Int
    
    init(name: String, imageURL: String, price: Double, stock: Int) {
        self.name = name
        self.imageURL = imageURL
        self.price = price
        self.stock = stock
    }
    
}
