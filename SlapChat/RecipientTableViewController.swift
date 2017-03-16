//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by TJ Carney on 3/16/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class RecipientTableViewController: UITableViewController {
    
    let store = DataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Recipients"
        store.fetchData()
        print(store.messages.count)
        print(store.recipients.count)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.fetchData()
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.recipients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipientCell", for: indexPath)
        let currentRecipient = store.recipients[indexPath.row].name
        cell.textLabel?.text = currentRecipient

        
        return cell
    }
    

    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageSegue" {
            if let destVC = segue.destination as? TableViewController, let indexPath = tableView.indexPathForSelectedRow {
                let selectedRecipient = store.recipients[indexPath.row]
                destVC.messages = selectedRecipient.messages!.allObjects as! [Message]
                destVC.recipient = selectedRecipient
            }
        }
    }
    

}
