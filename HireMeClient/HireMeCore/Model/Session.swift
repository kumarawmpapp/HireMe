//
//  Session.swift
//  HireMeCore
//
//  Created by Sanjeewa Bamunusinghe on 10/6/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class ApplicationSession {
    static let sharedInstance = ApplicationSession()
    
    var application: AppDelegate!
    var viewControllerFactory: ViewControllerFactory!
    var signupDetails: SignupDetails!
    
    private init() {
    }
    
    func hasActiveProfile() -> (Bool, Profile?) {
        if let profile = NSKeyedUnarchiver.unarchiveObject(withFile: Profile.ArchiveURL.path) as? Profile {
            return (true, profile)
        } else {
            return (false, nil)
        }
    }
}
