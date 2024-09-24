//
//  SignupInputView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 11/4/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class SignupInputView: CustomView {
    @IBOutlet weak var textField: BaseTextField!
    
    override func initView() {
        super.initView()
        
        
    }
    
    override func styleSubViews() {
        textField.borderStyle = .none
        self.contentView.backgroundColor = ApplicationColor.HEX_FFFFFF
    }
    
    override func localizeSubViews() {
        
    }
}
