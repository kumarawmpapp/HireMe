//
//  WebRequestHandler.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/25/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation
//import Alamofire
import GooglePlaces
import Utility

class WebRequestHandler {
    let webConnectionManager: WebConnectionManager
    let responseHandler: WebResponseHandler
    let webRequestQueue: DispatchQueue
    let webResponseQueue: DispatchQueue
    
    private let placesClient: GMSPlacesClient
    
    init() {
        webConnectionManager = WebConnectionManager()
        responseHandler = WebResponseHandler()
        webRequestQueue = DispatchQueue(label: "WebRequestQueue")
        webResponseQueue = DispatchQueue(label: "WebResponseQueue")
        
        placesClient = GMSPlacesClient()
    }
    
    func routeDetails(origin:String, destination:String, completionHandler: @escaping (RouteResponse?, Error?) -> Void) {
        webRequestQueue.async {
            let queryString = "origin=" + origin + "&destination=" + destination + "&key=" + ApplicationSettings.googleAPIKey
            let urlString: String = ApplicationSettings.googleDirectionAPIUrl + "?" + queryString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            if let url: URL = URL(string: urlString) {
                //                Alamofire.request(url).responseJSON { response in
                //                    if let json = response.result.value {
                //                    }
                //                }
                
                var urlRequest: URLRequest = URLRequest(url: url)
                urlRequest.httpMethod = "GET"
                self.webConnectionManager.sendURLRequest(urlRequest: urlRequest, completionHandler: { (data, error) in
                    self.webResponseQueue.async {
                        if error != nil {
                            DispatchQueue.main.sync {
                                completionHandler(nil, error)
                            }
                        } else {
                            let res = self.responseHandler.routeDetails(data)
                            DispatchQueue.main.sync {
                                completionHandler(res, error)
                            }
                        }
                    }
                })
            }
        }
    }
    
    func placeById(placeID: String, completionHandler: @escaping (Place?, Error?) -> Void) {
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            guard let place = place else {
                Log.debug("No place details for \(placeID)")
                return
            }
            
            completionHandler(Place(withGooglePlace: place), error) 
        })
    }
    
    func createCustomer(userDetails: SignupDetails) {
        webRequestQueue.async {
            var queryString = "Name=" + userDetails.user.firstName
            queryString = queryString + "&Email=" + userDetails.user.emailAddress
            queryString = queryString + "&Telephone=" + userDetails.user.phoneNumber
            queryString = queryString + "&ACN=" + userDetails.password
            queryString = queryString + "&CompanyID=1&BusinessGroupId=1&Status=1&CustomerTypeID=1"
            
            let urlString: String = ApplicationSettings.eHireCustomerUrl + "CreateCustomer"
            
            if let url: URL = URL(string: urlString) {
                //                Alamofire.request(url).responseJSON { response in
                //                    if let json = response.result.value {
                //                    }
                //                }
                
                var urlRequest: URLRequest = URLRequest(url: url)
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = queryString.data(using: .utf8)
                self.webConnectionManager.sendURLRequest(urlRequest: urlRequest, completionHandler: { (data, error) in
                    self.webResponseQueue.async {
                        if error != nil {
                            DispatchQueue.main.sync {
                                
                            }
                        } else {
                            let res = self.responseHandler.createCustomer(data)
                            DispatchQueue.main.sync {
                                
                            }
                        }
                    }
                })
            }
        }
    }
}
