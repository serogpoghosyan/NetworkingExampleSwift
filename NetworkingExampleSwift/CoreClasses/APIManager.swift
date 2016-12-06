//
//  APIManager.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 11/29/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private let session: URLSession
    
    init() {
        // Create and Configure a configuration for session
        let configuration = URLSessionConfiguration.default
        
        // Create URLSession instance
        session = URLSession(configuration: configuration)
    }
    
    // MARK: Network calls
    
    func loadDataWith(endpoint: String, completion: @escaping (_ receivedData: [String : Any]) -> Void) {
        
        // Create URL for request
        let requestURL = url(with: endpoint)
        
        // Create data task
        let dataTask = session.dataTask(with: requestURL, completionHandler: { (data, response, err) in
            
            // Completion handler
            // The response of the request is already received
            
            // Serialize received JSON
            if data != nil {
                if let objectData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) {
                    
                    // Get dictionary object
                    let object = objectData as! [String : Any]
                    
                    // Call completion clojure
                    completion(object)
                }
            } else if err != nil {
                // Handle error appropriately
                print(err!)
            }
            
        })
        
        // Send request
        dataTask.resume()
    }
}

extension APIManager {
    
    static let baseURL = "http://www.jin.am/api/jin/"
    
    struct EndPoint {
        static let categories = "categories"
        static let subCategories = "subCategories"
        static let productByID = "product_id"
    }
    
    fileprivate func url(with endPoint: String) -> URL {
        return URL(string: APIManager.baseURL + endPoint)!
    }
}
