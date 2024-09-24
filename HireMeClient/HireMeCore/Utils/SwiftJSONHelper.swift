//
//  SwiftJSONHelper.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/26/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

extension CLLocationCoordinate2D {
    static func makeFromGoogleAPI(json: JSON) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(json["lat"].doubleValue, json["lng"].doubleValue)
    }
}
