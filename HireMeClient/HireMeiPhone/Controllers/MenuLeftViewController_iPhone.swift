//
//  MenuLeftViewController.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/1/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

protocol MenuLeftViewControllerEventDelegate: NSObjectProtocol {
    func closeLeftView() -> Void // Close Event
}

class MenuLeftViewControllerIPhone: MenuLeftViewController {
    weak var delegate: MenuLeftViewControllerEventDelegate?

    @IBAction func closeClicked(_ sender: UIButton) {
        delegate?.closeLeftView()
    }
}
