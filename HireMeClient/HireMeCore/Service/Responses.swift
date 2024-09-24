//
//  Responses.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/25/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
import CoreLocation

struct RouteResponse {
    var overview_polyline: String!
    var start_location: CLLocationCoordinate2D!
    var end_location: CLLocationCoordinate2D!
    var bounds: Bounds!
    var distance: Double!
    var duration: Int!
}

struct Bounds {
    var northeast: CLLocationCoordinate2D!
    var southwest: CLLocationCoordinate2D!
}
