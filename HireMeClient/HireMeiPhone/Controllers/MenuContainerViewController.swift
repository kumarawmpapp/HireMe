//
//  MenuContainerViewController.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/2/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class MenuContainerViewController: SlideMenuController, MenuLeftViewControllerEventDelegate {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: BookingViewController.storyboardIdentifier) {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "MenuLeftViewControllerIPhone") as? MenuLeftViewControllerIPhone {
            self.leftViewController = controller
            controller.delegate = self
        }
        super.awakeFromNib()
        
        self.removeLeftGestures()
        self.removeRightGestures()
        
        self.view.sendSubview(toBack: self.topBarView)
        self.view.sendSubview(toBack: self.mainContainerView)
        
        self.titleLabel.text = mainViewController?.title
    }
    
    func addLeftMenuButton() {
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "global_menu")!, for: .normal)
        menuButton.addTarget(self, action: #selector(self.leftMenuClicked), for: .touchUpInside)
        
        menuButton.frame = CGRect(x: 10.0, y: 30.0, width: 30.0, height: 30.0)
        self.view.insertSubview(menuButton, aboveSubview: self.mainContainerView)
    }
    
    @IBAction func leftMenuClicked(_ sender: UIButton) {
        self.toggleLeft()
    }
    
    func closeLeftView() {
        self.toggleLeft()
    }

    func setMainControllerTitle(_ t: String) {
        self.titleLabel.text = t
    }
}
