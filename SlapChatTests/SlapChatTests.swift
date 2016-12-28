//
//  SlapChatTests.swift
//  SlapChatTests
//
//  Created by Johann Kerr on 12/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import XCTest
import CoreData
@testable import SlapChat

class SlapChatTests: XCTestCase {
    var store: DataStore!
    
    override func setUp() {
        super.setUp()
        store = DataStore.sharedInstance
    }
    
    
    override func tearDown() {
        super.tearDown()
        deleteAll(entity: "Message")
        store = nil
    }
    func testAddingRecipient() {
        let context = store.persistentContainer.viewContext
        let msg1 = Message(context: context)
        let recipient = Recipient(context: context)
        recipient.name = "Johann"
        recipient.email = "johann@flatironschool.com"
        recipient.phoneNumber = "6318357570"
        recipient.twitterHandle = "@johannkerr"
        recipient.addToMessages(msg1)
        XCTAssertEqual(recipient.messages?.count, 1)
    }
    
    func testFetchData() {
        deleteAll(entity: "Message")
        store.fetchData()
        XCTAssertEqual(store.messages.count, 3)
        
        let msg1 = Message(context: store.persistentContainer.viewContext)
        msg1.content = "Testing Message"
        msg1.createdAt = NSDate()
        store.saveContext()
        
        store.fetchData()
        XCTAssertEqual(store.messages.count, 4)
        
        
    }
    func testGenerateTestData() {
        
        
        deleteAll(entity: "Message")
        store.generateTestData()
        XCTAssert(store.messages.count > 0)
    }
    func deleteAll(entity: String) {
        let context = store.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                let managedObj = item as! NSManagedObject
                context.delete(managedObj)
                
            }
            store.saveContext()
        } catch {
            
        }
        
    }    
}
