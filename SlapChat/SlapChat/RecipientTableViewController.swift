//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class RecipientTableViewController: UITableViewController {
    
    var store: DataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.recipients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipientCell", for: indexPath)
        
        let currentRecipient = store.recipients[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = currentRecipient.name
        
        if let messageCount = currentRecipient.messages?.count{
            cell.detailTextLabel?.text = "\(messageCount)"
            
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let selectedRecipient = store.recipients[(indexPath! as NSIndexPath).row]
        
        let destinationVC = segue.destination as! TableViewController
        
        if let messageSet = selectedRecipient.messages{
            
            destinationVC.messages = messageSet
            
        }
    }
    
    
}
