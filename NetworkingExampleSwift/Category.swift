//
//  Category.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 11/29/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import Foundation

class Category {
    
    var id: Int
    var title: String?
    var order: Int?
    
    init?(withDictionary dictionary: [String : Any]) {
        if let id = dictionary["id"] as? Int {
            self.id = id
            self.title = dictionary["title"] as? String
            self.order = dictionary["order"] as? Int
        } else {
            return nil
        }
    }
}
