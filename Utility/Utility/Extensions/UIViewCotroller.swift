//
//  UIViewCotroller.swift
//  Utility
//
//  Created by Pradeep Kumara on 9/4/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

extension UIViewController {
    public func addChildController(childController: UIViewController, onView: UIView?) {
        var holderView = self.view
        if let onView = onView {
            holderView = onView
        }
        if let containerView = holderView {
            addChildViewController(childController)
            containerView.addSubview(childController.view)
            childController.view.frame = containerView.bounds
            UIView.constrainViewEqual(holderView: containerView, view: childController.view)
            childController.didMove(toParentViewController: self)
        }
    }
    
    public func removeChildController(content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
}
