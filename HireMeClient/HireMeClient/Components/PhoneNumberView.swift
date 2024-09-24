//
//  PhoneNumberView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 11/11/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import Utility

class PhoneNumberView: CustomView {
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtMobileNumber: BaseTextField!
    
    override func styleSubViews() {
        txtMobileNumber.delegate = self
        txtMobileNumber.keyboardType = .phonePad
    }
    
    override func localizeSubViews() {
        txtMobileNumber.placeholder = "Enter your mobile number"
    }
}

extension PhoneNumberView: DefaultTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtMobileNumber {
            if let textString = textField.text {
                if textString.length == 0 && string.characters.first == "0" {
                    return false
                } else if textString.length > 8 && string.length != 0 {
                    return false
                } else {
                    return true
                }
            }
            
        }
        return false
    }
}
