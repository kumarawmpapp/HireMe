//
//  Language.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/6/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class Language {
    class var sharedInstance: Language {
        if (true) {
            return English()
        } else {
            return Sinhala()
        }
    }
    
    // Menu
    var booking: String { return "" }
    var profile: String { return "" }
    
    // Booking
    var pickupTitle: String { return "" }
    var dropoffTitle: String { return "" }
    var enterLocation: String { return "" }
    var SOSButtonTitle: String { return "" }
    var bookingNowTitle: String { return "" }
    
    // Vehicles
    var threewheel: String { return "" }
    var nanocar: String { return "" }
    var minicar: String { return "" }
    var luxurycar: String { return "" }
    var van: String { return "" }
    
    // Set location
    var setLocationButtonTitle: String { return "" }
    
}

class English: Language {
    override var booking: String { return "BOOK TAXI" }
    override var profile: String { return "Profile" }
    
    override var pickupTitle: String { return "Pickup : " }
    override var dropoffTitle: String { return "Dropoff : " }
    override var enterLocation: String { return "Enter Location" }
    override var SOSButtonTitle: String { return "SOS" }
    override var bookingNowTitle: String { return "Book Now" }
    
    override var threewheel: String { return "Tuk" }
    override var nanocar: String { return "Nano" }
    override var minicar: String { return "Mini Car" }
    override var luxurycar: String { return "Luxury Car" }
    override var van: String { return "Van" }
    
    override var setLocationButtonTitle: String { return "Set Location" }
}

class Sinhala: English {
    override var booking: String { return "කුලී රථයක් ගැනීම" }
    override var profile: String { return "" }
    
    override var pickupTitle: String { return "ආරම්භක ස්ථානය : " }
    override var dropoffTitle: String { return "අවසාන ස්ථානය : " }
    override var enterLocation: String { return "ස්ථානය සඳහන් කරන්න" }
    override var SOSButtonTitle: String { return "හදිසි" }
    override var bookingNowTitle: String { return "බුක් කරන්න" }
    
    override var threewheel: String { return "ත්‍රී වීල්" }
    override var nanocar: String { return "නැනො" }
    override var minicar: String { return "පොඩි කාර්" }
    override var luxurycar: String { return "සැප කාර්" }
    override var van: String { return "වෑන්" }
}
