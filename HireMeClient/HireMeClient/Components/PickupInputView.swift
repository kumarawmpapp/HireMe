//
//  PickupInputView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/15/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

protocol PickupInputViewDelegate {
    func selectAddress(view: PickupInputView) -> Void
}

class PickupInputView: CustomView {
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var addressLabel: BaseLabel!
    @IBOutlet weak var selectAdrsButton: BaseButton!
    
    var delegate: PickupInputViewDelegate?
    
    override func initView() {
        super.initView()
    }
    
    override func styleSubViews() {
        backgroundColor = ApplicationColor.transparentColor
        
        contentView.backgroundColor = ApplicationColor.HEX_FFFFFF
        contentView.alpha = 0.9
        
        titleLabel.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Medium, size: 12.0)
        addressLabel.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Regular, size: 12.0)
        
        selectAdrsButton.backgroundColor = ApplicationColor.transparentColor
    }
    
    override func localizeSubViews() {
        addressLabel.text = activeLanguage.enterLocation
    }
    
    @IBAction func selectAdrsButtonClicked(_ sender: UIButton) {
        delegate?.selectAddress(view:self)
        
    }
}
