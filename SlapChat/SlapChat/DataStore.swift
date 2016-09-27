//
//  DataStore.swift
//  SlapChat
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

struct DataStore {
    
    var messages:[Message] = []
    var recipients: [Recipient] = []
    
    static let sharedDataStore = DataStore()
    
    
    // MARK: - Core Data Saving support
    
    mutating func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    mutating func fetchData ()
    {
        let recipientRequest = NSFetchRequest<Recipient>(entityName: "Recipient")
        
        let createdAtSorter = NSSortDescriptor(key: "name", ascending:true)
        
        recipientRequest.sortDescriptors = [createdAtSorter]
        
        do{
            
            recipients = try managedObjectContext.fetch(recipientRequest)
            
        }catch let error as NSError{
            
            print(error)
            recipients = []
        }
        
        if recipients.count == 0 {
            generateTestData()
        }
        
        ////         perform a fetch request to fill an array property on your datastore
    }
    
    mutating func generateTestData() {
        
        print("being called")
        
        
        let recipient1: Recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: managedObjectContext) as! Recipient
        recipient1.name = "Recipient 1"
        
        let recipient2: Recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: managedObjectContext) as! Recipient
        recipient2.name = "Recipient 2"
        
        let recipient3: Recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: managedObjectContext) as! Recipient
        recipient3.name = "Recipient 3"
        
        let messageOne: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedObjectContext) as! Message
        
        messageOne.content = "Message 1"
        messageOne.createdAt = Date()
        
        let messageTwo: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedObjectContext) as! Message
        
        messageTwo.content = "Message 2"
        messageTwo.createdAt = Date()
        
        let messageThree: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedObjectContext) as! Message
        
        messageThree.content = "Message 3"
        messageThree.createdAt = Date()
        
        
        let messageFour: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedObjectContext) as! Message
        
        messageFour.content = "Message 4"
        messageFour.createdAt = Date()
        
        
        let messageFive: Message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: managedObjectContext) as! Message
        
        messageFive.content = "Message 5"
        messageFive.createdAt = Date()
        
        recipient1.messages?.insert(messageOne)
        recipient1.messages?.insert(messageTwo)
        recipient2.messages?.insert(messageThree)
        recipient2.messages?.insert(messageFive)
        recipient3.messages?.insert(messageFour)
        print("messages: \(recipient1.messages)")
        
        saveContext()
        fetchData()
    }
    
    // MARK: - Core Data stack
    // Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "SlapChat", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: Application's Documents directory
    // Returns the URL to the application's Documents directory.
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
}
