//
//  PureLayoutExtension.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/25/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import PureLayout

extension UIView {
    func constraintCenterInSuperView() {
        self.autoCenterInSuperview()
    }
    
    func constraintSetSize(size: CGSize) {
        self.autoSetDimensions(to: size)
    }
    
    func constraintSetDimension(dim: NSLayoutAttribute, value: CGFloat) {
        self.autoSetDimension(convertLayoutAttributeDimension(dim: dim), toSize: value)
    }
    
    func constraintPinEdges() {
        self.autoPinEdgesToSuperviewEdges()
    }
    
    func constraintPinEdgesToSuperviewEdges(with insets: UIEdgeInsets, excludingEdge edge: NSLayoutAttribute) {
        self.autoPinEdgesToSuperviewEdges(with: insets, excludingEdge: convertLayoutAttributeEdges(edge: edge))
    }
    
    func convertLayoutAttributeEdges(edge:NSLayoutAttribute) -> ALEdge {
        switch edge {
        case .top:
            return ALEdge.top
        case .bottom:
            return ALEdge.bottom
        case .left:
            return ALEdge.left
        case .right:
            return ALEdge.right
        case .leading:
            return ALEdge.leading
        case .trailing:
            return ALEdge.trailing
        default:
            return ALEdge(rawValue: -1)!
        }
    }
    
    func convertLayoutAttributeDimension(dim: NSLayoutAttribute) -> ALDimension {
        switch dim {
        case .width:
            return ALDimension.width
        case .height:
            return ALDimension.height
        default:
            return ALDimension(rawValue: -1)!
        }
    }
}
