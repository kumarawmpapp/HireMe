//
//  ServiceManager.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/18/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class ServiceManager {
    static let sharedInstance = ServiceManager()
    let webServiceManager: WebManager

    private init() {
        webServiceManager = WebManager()
    }
}
