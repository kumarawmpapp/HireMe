//
//  Session.swift
//  HireMeCore
//
//  Created by Sanjeewa Bamunusinghe on 10/6/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

public class Session {
    public static let sharedInstance = Session()
    
    public func hasActiveProfile() -> Bool {
        return true
    }
}
