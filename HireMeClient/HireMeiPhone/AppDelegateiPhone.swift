//
//  AppDelegateiPhone.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/1/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegateiPhone: AppDelegate {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if (super.application(application, didFinishLaunchingWithOptions:launchOptions as? [UIApplicationLaunchOptionsKey : Any])) {
            return true
        }
        
        return false
    }
    
    override func createViewControllerFactory() -> ViewControllerFactory_iPhone {
        return ViewControllerFactory_iPhone()
    }
}
