//
//  MapViewController.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/4/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import GoogleMaps
import Utility
import SwiftyJSON

protocol MapViewControllerDelegate {
    func mapIdleAt(address: Address)
}

extension MapViewControllerDelegate {
    func mapIdleAt(address: Address){
        
    }
}

class MapViewController: BaseViewController {
    var locationManager: CLLocationManager!
    var geocoder: GMSGeocoder!
    var zoomLevel: Float = 15.0
    var mapView: GMSMapView!
    var cameraPosition: GMSMutableCameraPosition!
    var mapDispatchQueue: DispatchQueue!
    var delegate: MapViewControllerDelegate?
    
    override class var storyboardIdentifier: String {
        return "MapViewController"
    }
    
    override func initViewController() {
        super.initViewController()
        
        mapDispatchQueue = DispatchQueue(label: "MapDispatchQueue")
        geocoder = GMSGeocoder()
    }
    
    override func loadView() {
        cameraPosition = GMSMutableCameraPosition(target: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), zoom: zoomLevel, bearing: 0, viewingAngle: 0)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: cameraPosition)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        
        self.view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func updateMap() {
        DispatchQueue.main.async {
            self.mapView.animate(to: self.cameraPosition)
        }
    }
    
    
}



extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        mapDispatchQueue.async {
            self.geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
                self.mapDispatchQueue.async {
                    guard error == nil else {
                        return
                    }
                    
                    if let result = response?.firstResult() {
                        let addrss = Address(withGoogleAddress: result)
                        DispatchQueue.main.async {
                            self.delegate?.mapIdleAt(address: addrss)
                        }
                        
                    }
                }
            }
        }
        
    }
}

class LocationMapViewController: MapViewController {
    override func initViewController() {
        super.initViewController()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.startUpdatingLocation()
    }
    
    func resetMaptoCurrentLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationMapViewController: CLLocationManagerDelegate {
    fileprivate func didUpdateLocation(_ location: CLLocation) {
        logDebug("Location: \(location)")
        locationManager.stopUpdatingLocation()
        
        cameraPosition.target = location.coordinate
        cameraPosition.zoom = zoomLevel
        
        updateMap()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mapDispatchQueue.async {
            let location: CLLocation = locations.last!
            self.didUpdateLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapDispatchQueue.async {
            switch status {
            case .restricted:
                self.logDebug("Location access was restricted.")
            case .denied:
                self.logDebug("User denied access to location.")
                // Display the map using the default location.
                self.mapView.isHidden = false
            case .notDetermined:
                self.logDebug("Location status not determined.")
            case .authorizedAlways: fallthrough
            case .authorizedWhenInUse:
                self.logDebug("Location status is OK.")
            }
        }
        
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        mapDispatchQueue.async {
            self.locationManager.stopUpdatingLocation()
            self.logDebug("Error: \(error)")
        }
    }
}

class RouteMapViewController: MapViewController {
    var origin: CLLocationCoordinate2D!
    var destination: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func drawRoute(routeResponse: RouteResponse) {
        mapView.clear()
        mapView.isMyLocationEnabled = false
        
        let originmarker = GMSMarker(position: routeResponse.start_location)
        originmarker.map = mapView
        originmarker.icon = GMSMarker.markerImage(with: UIColor.green)
        
        let destinmarker = GMSMarker(position: routeResponse.end_location)
        destinmarker.map = mapView
        destinmarker.icon = GMSMarker.markerImage(with: UIColor.purple)

        let path = GMSPath(fromEncodedPath: routeResponse.overview_polyline)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.black
        polyline.map = mapView
        
        let bounds = GMSCoordinateBounds(path: path!)
        bounds.includingCoordinate(routeResponse.bounds.northeast)
        bounds.includingCoordinate(routeResponse.bounds.southwest)
        let cameraUpdate = GMSCameraUpdate.fit(bounds, with: UIEdgeInsetsMake(60.0, 10.0, 300.0, 10.0))
        
        mapView.animate(with: cameraUpdate)
    }
}
