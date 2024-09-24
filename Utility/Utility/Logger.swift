//
//  Logger.swift
//  Utility
//
//  Created by Pradeep Kumara on 9/5/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
import SwiftyBeaver

open class Log {
    static let sharedInstance = Log()
    let log = SwiftyBeaver.self
    
    private init() {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        log.addDestination(console)
    }
    
    open class func debug(_ message: @autoclosure () -> Any) {
        Log.sharedInstance.log.debug(message)
    }
}
