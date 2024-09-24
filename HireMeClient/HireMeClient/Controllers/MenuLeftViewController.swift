//
//  MenuLeftViewController.swift
//  HireMeClient
//
//  Created by Pradeep Kumara on 9/1/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import Utility

enum LeftMenu: Int {
    case main = 0
    case profile
    case mytrips
    case promotions
    case payment
    case emergency
    case aboutus
    case support
}

class MenuLeftViewController: BaseViewController {
    @IBOutlet weak var menuTable: UITableView!
    
    var menus = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateMenuItems()
        menuTable.reloadData()
    }
    
    override func styleViewController() {
        self.view.backgroundColor = ApplicationColor.HEX_FFFFFF
        
        menuTable.separatorStyle = .none
    }
    
    func populateMenuItems() {
        menus = [MenuItem(n: "Book Now", i: ImageLoader.loadLocalImage(imageType: LocalImage.Booking)),
                 MenuItem(n: "Profile", i: ImageLoader.loadLocalImage(imageType: LocalImage.Profile)),
        MenuItem(n: "My Trips", i: ImageLoader.loadLocalImage(imageType: LocalImage.MyTrips)),
        MenuItem(n: "Promotions", i: ImageLoader.loadLocalImage(imageType: LocalImage.Promotions)),
        MenuItem(n: "Payments", i: ImageLoader.loadLocalImage(imageType: LocalImage.Payments)),
        MenuItem(n: "Emergency", i: ImageLoader.loadLocalImage(imageType: LocalImage.Emergency)),
        MenuItem(n: "About Us", i: ImageLoader.loadLocalImage(imageType: LocalImage.AboutUs)),
        MenuItem(n: "Support", i: ImageLoader.loadLocalImage(imageType: LocalImage.Support))]
    }
}

extension MenuLeftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuTableViewCell.height()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MenuLeftViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTable.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        cell.setData(d: menus[indexPath.row])
        return cell
    }
}

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: MenuItemImageView!
    @IBOutlet weak var name: UILabel!
    
    class var identifier: String { return String.className(self) }
    
    class func height() -> CGFloat {
        return 48
    }
    
    func setData(d: MenuItem) {
        name.text = d.name
        
        if d.image != nil {
            iconImageView.image = d.image
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            self.alpha = 0.4
        } else {
            self.alpha = 1.0
        }
    }
}

class MenuItem {
    var image: UIImage?
    var name: String
    
    init(n:String) {
        name = n
    }
    
    init(n:String, i:UIImage) {
        name = n
        image = i
    }
}
