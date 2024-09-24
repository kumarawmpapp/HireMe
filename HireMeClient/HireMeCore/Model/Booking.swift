//
//  Booking.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/26/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class FareCalculator {
    class func priceForDistance(distance: Double) -> Double {
        var price = 210.0
        
        // distance ( m ) = noofkm ( km ) + noofm ( m )
        let noofm = distance.truncatingRemainder(dividingBy: 1000.0)
        let noofkm = distance.subtracting(noofm).divided(by: 1000.0)
        let kmafter3 = noofkm.subtracting(3.0)
        
        if kmafter3 > 0 {
            price = price + (kmafter3.multiplied(by: 64.0))
        }
        
        if noofm > 0 {
            price = price + 64.0
        }
        
        return price
    }
}
