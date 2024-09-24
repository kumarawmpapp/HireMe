//
//  GooglePlaces.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 11/3/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
import GooglePlaces

class AutocompletePrediction {
    var attributedFullText: NSAttributedString!
    var attributedPrimaryText: NSAttributedString!
    var attributedSecondaryText: NSAttributedString!
    var placeID: String!
    
    init(withGoogle prediction: GMSAutocompletePrediction) {
        self.attributedFullText = prediction.attributedFullText
        self.attributedPrimaryText = prediction.attributedPrimaryText
        self.attributedSecondaryText = prediction.attributedSecondaryText
        self.placeID = prediction.placeID
    }
}

class Place {
    var coordinate: CLLocationCoordinate2D!
    var name: String!
    
    init(withGooglePlace place: GMSPlace) {
        self.coordinate = place.coordinate
        self.name = place.name
    }
}

