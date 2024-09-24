//
//  SetLocationViewController.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/19/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
//import GoogleMaps
import GooglePlaces
import Utility

protocol LocationViewControllerDelegate {
    func setLocationWithAddress(address: Address, locationViewController: SetLocationViewController) -> Void
}

class SetLocationViewController: BaseViewController {
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var setLocationButton: BaseButton!
    @IBOutlet weak var addrsInputView: UIView!
    @IBOutlet weak var addrsInputViewImageView: UIImageView!
    @IBOutlet weak var addrsInputViewTextField: BaseTextField!
    @IBOutlet weak var favouritButton: BaseButton!
    @IBOutlet weak var markerImageView: UIImageView!
    @IBOutlet weak var currentLocation: BookingCircleButton!
    @IBOutlet weak var suggestionsView: SuggestionsView!
    
    @IBOutlet weak var suggestionsViewBottom: NSLayoutConstraint!
    
    var locationMapViewController: LocationMapViewController!
    var address: Address!
    var delegate: LocationViewControllerDelegate?
    var fetcher: GMSAutocompleteFetcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationMapViewController = LocationMapViewController()
        locationMapViewController.delegate = self
        self.addChildController(childController: locationMapViewController, onView: self.mapView)
    
        favouritButton.isHidden = true
        
        let neBoundsCorner = CLLocationCoordinate2D(latitude: 9.965331,
                                                    longitude: 82.004178)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: 5.787577,
                                                    longitude: 79.601723)
        let bounds = GMSCoordinateBounds(coordinate: neBoundsCorner,
                                         coordinate: swBoundsCorner)
        
        // Set up the autocomplete filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "lk"
        
        // Create the fetcher.
        fetcher = GMSAutocompleteFetcher(bounds: bounds, filter: filter)
        fetcher.delegate = self
        
        addrsInputViewTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        addrsInputViewTextField.addTarget(self, action: #selector(textFieldDidBegin(textField:)), for: .editingDidBegin)
        
        addrsInputViewTextField.addTarget(self, action: #selector(textFieldDidEnd(textField:)), for: .editingDidEnd)
        
        suggestionsView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func styleViewController() {
        setLocationButton.backgroundColor = ApplicationColor.HEX_525252
        setLocationButton.setTitleColor(ApplicationColor.HEX_FFFFFF, for: .normal)
        
        addrsInputView.backgroundColor = ApplicationColor.HEX_FFFFFF
        addrsInputView.alpha = 0.8
        
        addrsInputViewTextField.borderStyle = .none
        
        let pickupImage = ImageLoader.loadLocalImage(imageType: .Pickup)
        self.markerImageView.image = pickupImage
        self.markerImageView.contentMode = .scaleAspectFit
        
        currentLocation.setImage(#imageLiteral(resourceName: "currentlocation"), for: .normal)
        currentLocation.tintColor = ApplicationColor.HEX_FFFFFF
        currentLocation.backgroundColor = ApplicationColor.HEX_525252
    }
    
    override func localizeViewController() {
        setLocationButton.setTitle(activeLanguage.setLocationButtonTitle, for: .normal)
    }
    
    @IBAction func currentLocationButtonClicked(_ sender: UIButton) {
        locationMapViewController.resetMaptoCurrentLocation()
    }
    
    @IBAction func setLocationButtonClicked(_ sender: UIButton) {
        guard (self.address != nil) else {
            return
        }
        delegate?.setLocationWithAddress(address: self.address, locationViewController: self)
    }
    
    func textFieldDidChange(textField: UITextField) {
        fetcher.sourceTextHasChanged(textField.text)
    }
    
    func textFieldDidBegin(textField: UITextField) {
        suggestionsViewBottom.constant = -250.0
    }
    
    func textFieldDidEnd(textField: UITextField) {
        suggestionsViewBottom.constant = 0.0
    }
    
    func locationChanged() {
        addrsInputViewTextField.text = self.address.thoroughfare
        
        locationMapViewController.cameraPosition.target = self.address.coordinate
        locationMapViewController.updateMap()
    }
}

extension SetLocationViewController: MapViewControllerDelegate {
    func mapIdleAt(address: Address) {
        self.address = address
        self.addrsInputViewTextField.text = self.address.thoroughfare
    }
}

extension SetLocationViewController: GMSAutocompleteFetcherDelegate {
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        SetLocationViewController.viewControllerDispatchQueue.async {
            self.refreshPredictions(predictions: predictions)
        }
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        logDebug(error.localizedDescription)
    }
    
    func refreshPredictions(predictions: [GMSAutocompletePrediction]) {
        var predictionsArray = [AutocompletePrediction]()
        for prediction in predictions {
            predictionsArray.append(AutocompletePrediction(withGoogle: prediction))
        }
        suggestionsView.suggestionsArray = predictionsArray
    }
}

extension SetLocationViewController: SuggestionViewDelegate {
    func suggestionsViewSelect(withItem item: AutocompletePrediction) {
        addrsInputViewTextField.resignFirstResponder()
        ServiceManager.sharedInstance.webServiceManager.requestHandler.placeById(placeID: item.placeID) { (place, error) in
            self.address.thoroughfare = place?.name
            self.address.coordinate = place?.coordinate
            
            self.locationChanged()
        }
    }
}
