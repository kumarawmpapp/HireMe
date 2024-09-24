//
//  BaseViews.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/30/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import Utility

class BaseView: UIView {
    var activeLanguage: Language {
        return Language.sharedInstance
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        
    }
}

class CustomView: BaseView {
    @IBOutlet weak var contentView: UIView!
    
    override func initView() {
        super.initView()
        loadCustomNib()
        addSubview(contentView)
        contentView.constraintPinEdges()
        styleSubViews()
        localizeSubViews()
    }
    
    func loadCustomNib() {
        Bundle.main.loadNibNamed(self.className, owner: self, options: nil)
    }
    
    func styleSubViews() {
        
    }
    
    func localizeSubViews() {
        
    }
}

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        
    }
}

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        
    }
}

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        self.substituteFontName = ApplicationFonts.generalFontName()
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
}

class BaseTextField: DefaultTextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    func initView() {
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 5.0
    }
}

class BaseButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    func initView() {
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.4
    }
}
