//
//  BookingViewController.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/12/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
//import GoogleMaps

class BookingViewController: BaseViewController {
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var markerView: UIImageView!
    @IBOutlet weak var vehicleView: VehicleView!
    @IBOutlet weak var sosButton: BookingCircleButton!
    @IBOutlet weak var filterButton: BookingCircleButton!
    @IBOutlet weak var currentLocationButton: BookingCircleButton!
    @IBOutlet weak var bookingButtonView: BookingNowView!
    
    @IBOutlet weak var pickupInput: PickupInputView!
    @IBOutlet weak var dropoffInput: PickupInputView!
    
    fileprivate var pickupLocationViewController: SetLocationViewController!
    fileprivate var dropoffLocationViewController: SetLocationViewController!
    
    var pickupAddress: Address!
    var dropoffAddress: Address!
    
    var locationMapViewController: LocationMapViewController!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = activeLanguage.booking
    }
    
    override func initViewController() {
        super.initViewController()
        
        
    }
    
    override func viewDidLoad() {
        bookingButtonView.delegate = self
        pickupInput.delegate = self
        dropoffInput.delegate = self
        
        super.viewDidLoad()

        addBookingNowMapView()
        addPickupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func styleViewController() {
        sosButton.backgroundColor = ApplicationColor.HEX_E77373
        sosButton.setTitleColor(ApplicationColor.HEX_FFFFFF, for: .normal)
        sosButton.titleLabel?.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Medium, size: 10.0)
        
        currentLocationButton.imageView?.tintColor = ApplicationColor.HEX_FFFFFF
        currentLocationButton.backgroundColor = ApplicationColor.HEX_343434
        
        vehicleView.alpha = 0.8
    }
    
    override func localizeViewController() {
        pickupInput.titleLabel.text = activeLanguage.pickupTitle
        dropoffInput.titleLabel.text = activeLanguage.dropoffTitle
        
        sosButton.setTitle(activeLanguage.SOSButtonTitle, for: .normal)
        
        
    }
    
    @IBAction func currentLocationButtonClicked(_ sender: UIButton) {
        locationMapViewController.resetMaptoCurrentLocation()
    }
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func sosButtonClicked(_ sender: UIButton) {
        
    }
    
    func addBookingNowMapView() {
        locationMapViewController = LocationMapViewController()
        locationMapViewController.delegate = self
        self.addChildController(childController: locationMapViewController, onView: self.mapView)
    }
    
    func removeBookingNowMapView() {
        self.removeChildController(content: locationMapViewController)
    }
    
    
    
    
    func addPickupView() {
        let pickupImage = ImageLoader.loadLocalImage(imageType: .Pickup)
        self.markerView.image = pickupImage
        self.markerView.contentMode = .scaleAspectFit
    }
    
    func getPickupLocationViewController() -> SetLocationViewController {
        if pickupLocationViewController == nil {
            pickupLocationViewController = ApplicationSession.sharedInstance.viewControllerFactory.locationViewController()
            pickupLocationViewController.delegate = self
        }
        
        return pickupLocationViewController
    }
    
    func getDropOffLocationViewController() -> SetLocationViewController {
        if dropoffLocationViewController == nil {
            dropoffLocationViewController = ApplicationSession.sharedInstance.viewControllerFactory.locationViewController()
            dropoffLocationViewController.delegate = self
        }
        
        return dropoffLocationViewController
    }
}

extension BookingViewController: BookingNowViewDelegate {
    func bookingNow() {
        let viewcontroller: BookingConfirmViewController = ApplicationSession.sharedInstance.viewControllerFactory.bookingConfirmViewController()
        viewcontroller.pickupAddress = self.pickupAddress
        viewcontroller.dropoffAddress = self.dropoffAddress
        
        self.present(viewcontroller, animated: false) {
            
        }
    }
}

extension BookingViewController: PickupInputViewDelegate {
    func selectAddress(view: PickupInputView) {
        var viewcontroller: SetLocationViewController!
        
        if view == pickupInput {
            viewcontroller = self.getPickupLocationViewController()
        } else if view == dropoffInput {
            viewcontroller = self.getDropOffLocationViewController()
            
        }
        self.present(viewcontroller, animated: true) {
            
        }
    }
}

extension BookingViewController: MapViewControllerDelegate {
    func mapIdleAt(address: Address) {
        self.pickupAddress = address
        self.pickupInput.addressLabel.text = address.thoroughfare
    }
}

extension BookingViewController: LocationViewControllerDelegate {
    func setLocationWithAddress(address: Address, locationViewController: SetLocationViewController) {
        if locationViewController == pickupLocationViewController {
            pickupAddress = address
            pickupInput.addressLabel.text = pickupAddress.thoroughfare
        } else if locationViewController == dropoffLocationViewController {
            dropoffAddress = address
            dropoffInput.addressLabel.text = dropoffAddress.thoroughfare
        }
        locationViewController.dismiss(animated: true) {
            
        }
    }
}

class BookingCircleButton: CircleButton {
    override func initView() {
        super.initView()
        
        self.imageEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
    }
}
