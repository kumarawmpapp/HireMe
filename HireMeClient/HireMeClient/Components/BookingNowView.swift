//
//  BookingNowView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/18/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

protocol BookingNowViewDelegate {
    func bookingNow() -> Void
}

class BookingNowView: CustomView {
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var bookLaterButton: UIButton!
    
    var delegate: BookingNowViewDelegate?
    
    override func styleSubViews() {
        bookNowButton.backgroundColor = ApplicationColor.HEX_FDCD2F
        bookNowButton.setTitleColor(ApplicationColor.HEX_525252, for: .normal)
    }
    override func localizeSubViews() {
        bookNowButton.setTitle(activeLanguage.bookingNowTitle, for: .normal)
    }
    
    @IBAction func bookingNowButtonClicked(_ sender: UIButton) {
        delegate?.bookingNow()
    }
}
