//
//  TextField.swift
//  Utility
//
//  Created by Sanjeewa Bamunusinghe on 10/15/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

@objc public protocol DefaultTextFieldDelegate: UITextFieldDelegate {
    @objc optional func textFieldDidDelete(_ textField: UITextField)
    @objc optional func textFieldDidChange(_ textField: UITextField)
}

open class DefaultTextField: UITextField, DefaultTextFieldDelegate {
    var trueDelegate:DefaultTextFieldDelegate?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    fileprivate func initView() {
        self.delegate=self
        self.spellCheckingType = .no
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.returnKeyType = .done
        self.borderStyle = .none
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 5.0
        
        viewCloseAccessory()
        
        self.addTarget(self, action: #selector(DefaultTextField.textFieldEditingChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    override weak open var delegate: UITextFieldDelegate? {
        didSet {
            if delegate !== self {
                trueDelegate=delegate as? DefaultTextFieldDelegate
                self.delegate=self
            }
        }
    }
    
    open override func deleteBackward() {
        super.deleteBackward()
        
        trueDelegate?.textFieldDidDelete?(self)
    }
    
    func textFieldEditingChanged(textField: UITextField) {
        trueDelegate?.textFieldDidChange?(self)
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let value = trueDelegate?.textFieldShouldBeginEditing?(textField) else { return true }
        return value
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField)
    {
        trueDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        guard let value = trueDelegate?.textFieldShouldEndEditing?(textField) else { return true }
        return value
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField)
    {
        trueDelegate?.textFieldDidEndEditing?(textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let value = trueDelegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: string) else { return true }
        return value
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        guard let value = trueDelegate?.textFieldShouldClear?(textField) else { return true }
        return value
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.resignFirstResponder()
        guard let value = trueDelegate?.textFieldShouldReturn?(textField) else { return true }
        return value
    }
    
    func numberPadAccossoryCloseButtonClicked() {
        self.resignFirstResponder()
    }
    
    open override var keyboardType: UIKeyboardType {
        didSet {
            viewCloseAccessory()
        }
    }
    
    fileprivate func viewCloseAccessory() {
        if [.numberPad, .phonePad].contains(self.keyboardType) {
            let closedoneview = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
            closedoneview.backgroundColor = UIColor.white
            
            let closeButton = UIButton(type: .custom)
            closeButton.setTitle("\u{274C}", for: .normal)
            closeButton.addTarget(self, action: #selector(DefaultTextField.numberPadAccossoryCloseButtonClicked), for: .touchUpInside)
            closeButton.backgroundColor = UIColor.clear
            closeButton.setTitleColor(UIColor.black, for: .normal)
            
            closedoneview.addSubview(closeButton)
            
            closedoneview.translatesAutoresizingMaskIntoConstraints = false
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            
            closedoneview.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: closedoneview, attribute: .top, multiplier: 1.0, constant: 5.0))
            closedoneview.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .bottom, relatedBy: .equal, toItem: closedoneview, attribute: .bottom, multiplier: 1.0, constant: -5.0))
            closedoneview.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: closedoneview, attribute: .leading, multiplier: 1.0, constant: 5.0))
            closeButton.addConstraint(NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: closeButton, attribute: .height, multiplier: 1.0, constant: 0.0))
            
            self.inputAccessoryView = closedoneview
        }
    }
}
