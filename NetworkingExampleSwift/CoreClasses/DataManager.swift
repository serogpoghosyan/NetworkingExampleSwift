//
//  DataManager.swift
//  NetworkingExampleSwift
//
//  Created by Seryozha Poghosyan on 12/1/16.
//  Copyright © 2016 Workfront. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    init() {
        //
    }
    
    // Public Interface
    
    func loadCategories(completion: @escaping (_ categories: [Category]) -> Void) -> [Category] {
        APIManager.shared.loadDataWith(endpoint: APIManager.EndPoint.categories) { (object) in
            DispatchQueue.main.async {
                var resultArr = [Category]()
                if let results = object["results"] as? [[String : Any]] {
                    var tempCategories = [Category]()
                    for categoryDictionary in results {
                        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: self.persistentContainer.viewContext) as! Category
                        category.setCategoryInfo(categoryDictionary)
                        tempCategories.append(category)
                    }
                    self.saveContext()
                    resultArr = tempCategories
                }
                completion(resultArr)
            }
        }
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "id=8")
        if let result = try? self.persistentContainer.viewContext.fetch(fetchRequest) {
            return result
        } else {
            return [Category]()
        }
    }
    
    func loadSubCategories(completion: @escaping (_ subCategories: [Category]) -> Void) {
        APIManager.shared.loadDataWith(endpoint: APIManager.EndPoint.subCategories) { (object) in
            //
        }
    }
    
    // MARK: - Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "NetworkingExampleSwift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
