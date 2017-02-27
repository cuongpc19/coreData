//
//  CoreDataStack.swift
//  TodoList
//
//  Created by AgribankCard on 2/27/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//


import Foundation
import CoreData
class CoreDataStack {
    static let sharedInstance = CoreDataStack()
    let modelName = "TodoList"
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    //1
    lazy var context: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.psc
        return managedObjectContext
    }()
    
    //2
    private lazy var psc: NSPersistentStoreCoordinator = { let coordinator = NSPersistentStoreCoordinator(
        managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(self.modelName)
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption : true]
            try coordinator.addPersistentStore( ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            print("Error adding persistent store.")
        }
        return coordinator }()
    //3
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.modelName,withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)! }()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                abort()
            } }
    }
    
}
