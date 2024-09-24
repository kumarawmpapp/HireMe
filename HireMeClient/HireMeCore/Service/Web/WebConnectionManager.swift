//
//  WebConnectionManager.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/25/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class WebConnectionManager {
    func sendURLRequest(urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let urlSession = URLSession.shared
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            completionHandler(data, error)
            }.resume()
    }
}
