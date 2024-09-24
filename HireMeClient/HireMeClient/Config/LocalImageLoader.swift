//
//  LocalImageLoader.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/6/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

enum LocalImage: Int {
    case Booking = 0
    case Profile
    case MyTrips
    case Promotions
    case Payments
    case Emergency
    case AboutUs
    case Support
    case Pickup
    case ThreeWheel
}

class ImageLoader {
    class func loadLocalImage(imageType: LocalImage) -> UIImage {
        var image: UIImage!
        
        switch imageType {
        case LocalImage.Booking:
            image = UIImage(named: "booking")
        case LocalImage.Profile:
            image = UIImage(named: "profile")
        case LocalImage.MyTrips:
            image = UIImage(named: "trips")
        case LocalImage.Promotions:
            image = UIImage(named: "promotions")
        case LocalImage.Support:
            image = UIImage(named: "support")
        case LocalImage.Payments:
            image = UIImage(named: "payments")
        case LocalImage.Emergency:
            image = UIImage(named: "emergency")
        case LocalImage.AboutUs:
            image = UIImage(named: "aboutus")
        case LocalImage.Pickup:
            image = UIImage(named: "pickup")
        case .ThreeWheel:
            image = #imageLiteral(resourceName: "threewheel")
        }
        
        return (image != nil) ? image! : UIImage()
    }
}
