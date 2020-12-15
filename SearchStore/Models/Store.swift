//
//  Stores.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 18/11/2020.
//

import Foundation
import CoreLocation

class Store: CustomStringConvertible {
    var name: String
    var location = CLLocationCoordinate2D()
    var product: [Product]
    
    init(name: String, latitude: Double, longitude: Double, product: [Product]) {
        self.name = name
        self.location.latitude = latitude
        self.location.longitude = longitude
        self.product = product
    }
    
    var description: String {
        return "{\(self.name) \(self.location.latitude) \(self.location.longitude)}"
    }
}
