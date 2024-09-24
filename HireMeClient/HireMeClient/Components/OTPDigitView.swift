//
//  OTPDigitView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 11/8/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import Utility

class OTPDigitView: CustomView {
    @IBOutlet weak var txtDigitView: BaseTextField!
    
    @IBOutlet weak var nextDigitView: OTPDigitView!
    @IBOutlet weak var prevDigitView: OTPDigitView!
    
    var deleteCount: Int = 1
    
    override func styleSubViews() {
        txtDigitView.delegate = self
        txtDigitView.keyboardType = .numberPad
        txtDigitView.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Bold, size: 18.0)
    }
}

extension OTPDigitView: DefaultTextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.length > 0 {
            deleteCount = 1
        }
        
        if let textString = textField.text {
            if ((textString.length > 0 && string.length == 0) || (textString.length == 0 && string.length > 0)) {
                return true
            } else if (textString.length > 0 && string.length > 0) {
                if let next = nextDigitView {
                    next.txtDigitView.text = string
                    next.txtDigitView.becomeFirstResponder()
                }
                return false
            }
        }
        
        return false
    }
    
    func textFieldDidDelete(_ textField:UITextField) {
        deleteCount -= 1
        if let textString = textField.text {
        if (textString.length == 0 && deleteCount < 0) {
            if let prev = prevDigitView {
                prev.txtDigitView.text = ""
                prev.txtDigitView.becomeFirstResponder()
            }
        }
        }
    }
}
