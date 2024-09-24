//
//  BookingConfirmViewController.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/23/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class BookingConfirmViewController: BaseViewController {
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var cancelButton: BaseButton!
    @IBOutlet weak var bookingPrice: BaseLabel!

    var pickupAddress: Address!
    var dropoffAddress: Address!
    
    var routeMapViewController: RouteMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dropoffAddress != nil {
            addRouteMapView()
            ServiceManager.sharedInstance.webServiceManager.requestHandler.routeDetails(origin: "\(pickupAddress.coordinate.latitude),\(pickupAddress.coordinate.longitude)", destination: "\(dropoffAddress.coordinate.latitude),\(dropoffAddress.coordinate.longitude)", completionHandler: { (routeResponse, error) in
                if let routeResponse = routeResponse {
                    self.routeMapViewController.drawRoute(routeResponse: routeResponse)
                    self.bookingPrice.text = String(FareCalculator.priceForDistance(distance: routeResponse.distance))
                }
            })
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonClicked(_ sender:UIButton){
        self.dismiss(animated: true) {
            
        }
    }

    func addRouteMapView() {
        routeMapViewController = RouteMapViewController()
        routeMapViewController.origin = pickupAddress.coordinate
        routeMapViewController.destination = dropoffAddress.coordinate
        self.addChildController(childController: routeMapViewController, onView: self.mapView)
    }
}

