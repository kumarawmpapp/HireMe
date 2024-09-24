//
//  GoogleMaps.swift
//  HireMeiPhone
//
//  Created by Sanjeewa Bamunusinghe on 11/4/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
import GoogleMaps

class Address {
    var coordinate: CLLocationCoordinate2D!
    var thoroughfare: String?
    
    init(withGoogleAddress address: GMSAddress) {
        self.coordinate = address.coordinate
        self.thoroughfare = address.thoroughfare
    }
}
