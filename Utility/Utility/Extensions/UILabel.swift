//
//  UILabel.swift
//  Utility
//
//  Created by Sanjeewa Bamunusinghe on 10/3/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

public extension UILabel {
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
}
