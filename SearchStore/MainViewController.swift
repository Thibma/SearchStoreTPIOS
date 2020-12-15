//
//  MainViewController.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 18/11/2020.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var searchWidget: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    let storeWebServices: StoreWebServices = StoreWebServices()
    
    var storeList = [Store]()
    var storePointAnnotation = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            let locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.locationManager = locationManager
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.mapView.delegate = self
        self.searchWidget.delegate = self
        
        self.storeWebServices.getAllStore(completion: { (stores) in
            self.storeList = stores
            self.setAnnotationPoint()
        })
    }
    
    func setAnnotationPoint() {
        for store in self.storeList {
            let point = MKPointAnnotation()
            point.title = store.name
            point.coordinate = CLLocationCoordinate2D(latitude: store.location.latitude, longitude: store.location.longitude)
            self.storePointAnnotation.append(point)
        }
        self.mapView.addAnnotations(self.storePointAnnotation)
    }
    
    func detailStore(store: Store) {
        let productListViewController = ProductListViewController.newInstance(store: store)
        self.navigationController?.pushViewController(productListViewController, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let loc = userLocation.location else {
            return
        }
        
        mapView.setRegion(MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000), animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        for i in 0..<storePointAnnotation.count {
            if view.annotation?.title == storePointAnnotation[i].title && view.annotation?.coordinate.latitude == storePointAnnotation[i].coordinate.latitude && view.annotation?.coordinate.longitude == storePointAnnotation[i].coordinate.longitude {
                detailStore(store: storeList[i])
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        var storeSearch: Store? = nil
        for store in storeList {
            if store.name.localizedCaseInsensitiveContains(searchBar.text!) {
                storeSearch = store
                break
            }
        }
        if storeSearch == nil {
            return
        }
        
        mapView.setRegion(MKCoordinateRegion(center: storeSearch!.location, latitudinalMeters: 5000, longitudinalMeters: 5000), animated: true)
    }
}
