//
//  WebResponseHandler.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/25/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
import SwiftyJSON
import Utility
import CoreLocation

class WebResponseHandler {
    func routeDetails(_ data:Data?) -> RouteResponse? {
        if let d = data {
            let json = JSON(d)
            
            var routeResponse = RouteResponse()
            
            let routes_0 = json["routes"][0]
            let routes_0_bounds = routes_0["bounds"]
            
            var bounds = Bounds()
            bounds.northeast = CLLocationCoordinate2D.makeFromGoogleAPI(json: routes_0_bounds["northeast"])
            bounds.southwest = CLLocationCoordinate2D.makeFromGoogleAPI(json: routes_0_bounds["southwest"])
            routeResponse.bounds = bounds
            
            let routes_0_legs_0 = routes_0["legs"][0]
            
            routeResponse.start_location = CLLocationCoordinate2D.makeFromGoogleAPI(json: routes_0_legs_0["start_location"])
            routeResponse.end_location = CLLocationCoordinate2D.makeFromGoogleAPI(json: routes_0_legs_0["end_location"])
            
            routeResponse.distance = routes_0_legs_0["distance"]["value"].doubleValue
            
            routeResponse.overview_polyline = routes_0["overview_polyline"]["points"].stringValue
            
            return routeResponse
        }
        return nil
    }
    
    func createCustomer(_ data:Data?) {
        if let d = data {
            let json = JSON(d)
        }
    }
}
