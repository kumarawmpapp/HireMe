//
//  AppConfigs.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/18/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class ApplicationSettings {
    // Google
    static var googleAPIUrl = "https://maps.googleapis.com/maps/api/"
    static let googleAPIKey = ""
    static let googleAPIResponseFormat = "json"
    static let googleDirectionAPIUrl = ApplicationSettings.googleAPIUrl + "directions/" + ApplicationSettings.googleAPIResponseFormat
    
    // E-Hire
    static var eHireAPIUrl = "http://ehire.quadroople.com/api/"
    static var eHireCustomerUrl = ApplicationSettings.eHireAPIUrl + "Customer/"
    
}
