//
//  Category+CoreDataProperties.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 12/1/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var id: NSNumber?
    @NSManaged public var order: NSNumber?
    @NSManaged public var title: String?

}
