//
//  CategoriesViewController.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 11/27/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import UIKit

private let categoriesURL = "http://www.jin.am/api/jin/categories"

class CategoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadCategories(completion: { (categories) in
            print(categories)
        })
    }
    
    private func loadCategories(completion: @escaping (_ receivedData: [String : Any]) -> Void) {
        
        // Create and Configure a configuration for session
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        
        // Create URLSession instance
        let session = URLSession(configuration: configuration)
        
        // Create URL for request
        if let requestURL = URL(string: categoriesURL) {
            
            // Create data task
            let dataTask = session.dataTask(with: requestURL, completionHandler: { (data, response, err) in
                
                // Completion handler
                // The response of the request is already received
                
                // Serialize received JSON
                if data != nil {
                    if let categoriesData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions()) {
                        
                        // Get dictionary object
                        let categoriesDictionary = categoriesData as! [String : Any]
                        
                        // Call completion clojure
                        DispatchQueue.main.async {
                            completion(categoriesDictionary)
                        }
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
}
