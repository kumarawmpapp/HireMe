//
//  AppFonts.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/15/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class ApplicationFonts {
    static let sharedInstance = ApplicationFonts()
        
    class func generalFont(withSize size: CGFloat) -> UIFont {
        return ApplicationFonts.generalFont(withName: ApplicationFonts.generalFontName(), size: size)
    }
    
    class func generalFont(withName fontName: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        
        return font
    }
    
    class func generalFontName() -> String {
        return ApplicationFonts.Montserrat.Regular
    }
    
    class Montserrat: FontFamily {
        static let Regular = "Montserrat-Regular"
        static let Medium = "Montserrat-Medium"
        static let Bold = "Montserrat-Bold"
    }
}

class FontFamily {
    
}
