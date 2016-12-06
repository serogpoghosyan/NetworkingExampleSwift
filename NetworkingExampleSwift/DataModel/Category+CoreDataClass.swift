//
//  Category+CoreDataClass.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 12/1/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

    func setCategoryInfo(_ dictionary: [String : Any]) {
        if let id = dictionary["id"] as? NSNumber {
            self.id = id
            self.title = dictionary["title"] as? String
            self.order = dictionary["order"] as? NSNumber
        }
    }
}
