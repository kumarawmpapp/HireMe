//
//  CustomizedViews.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/30/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class CircleButton: BaseButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    override func initView() {
        super.initView()
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
}

class MenuItemImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.backgroundColor = ApplicationColor.HEX_525252
        self.tintColor = ApplicationColor.HEX_FDCD2F
    }
}

