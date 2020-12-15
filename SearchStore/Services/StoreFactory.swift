//
//  StoreFactory.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 18/11/2020.
//

import Foundation

class StoreFactory {
    
    static func storeFrom(dictionnary: [String: Any]) -> Store? {
        guard let n = dictionnary["name"] as? String,
              let l = dictionnary["location"] as? [String: Any],
              let p = dictionnary["products"] as? [AnyObject],
              
              let lat = l["lat"] as? Double,
              let long = l["lon"] as? Double else {
            
            
            return nil
            
        }
        var products = [Product]()
        
        for product in p {
            guard let pn = product["name"] as? String,
                  let pi = product["image"] as? String,
                  let pp = product["price"] as? Double,
                  let ps = product["stock"] as? Int else {
                return nil
            }
            products.append(Product(name: pn, imageURL: pi, price: pp, stock: ps))
        }
        
        let store = Store(name: n, latitude: lat, longitude: long, product: products)
        return store
    }
}
