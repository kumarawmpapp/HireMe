//
//  BaseViewController.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/4/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import Utility

class BaseViewController: UIViewController {
    class var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    var activeLanguage: Language {
        return Language.sharedInstance
    }
    
    var appDelegate: AppDelegate {
        return ApplicationSession.sharedInstance.application
    }
    
    static var viewControllerDispatchQueue = DispatchQueue(label: "ViewControllerDispatchQueue")
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initViewController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleSubViewController();
        localizeViewController();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Log.debug("Memory Warning")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    func updateSubViewConstraints() {
    }
    
    private func styleSubViewController() {
        self.view.backgroundColor = ApplicationColor.HEX_FDCD2F
        styleViewController()
    }
    
    func initViewController() {
        
    }
    
    func localizeViewController() {
    }
    
    func styleViewController() {
    }
    
    func logDebug(_ message: @autoclosure () -> Any) {
        Log.debug(message)
    }
    
    func findActiveResponderFrame(view:UIView)->UIView?{
        if view.isFirstResponder {
            return view
        } else {
            for subView in view.subviews {
                return findActiveResponderFrame(view: subView)
            }
        }
        return nil
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            
            var height: CGFloat = 0.0
            
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                height = 0.0
            } else {
                height = endFrame?.size.height ?? 0.0
            }
            
            let activeView = findActiveResponderFrame(view: self.view)
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: {
                            var viewFrame = self.view.frame
                            viewFrame.origin.y -= height
                            self.view.frame = viewFrame
            })
        }
    }
}
