//
//  TableViewController.swift
//  SlapChat
//
//  Created by Ian Rahman on 7/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var store = DataStore.sharedInstance
    var messages: [Message] = []
    var recipient: Recipient? 

    override func viewDidLoad() {
        super.viewDidLoad()
        if let recipient = recipient?.name {
        navigationItem.title = ("\(recipient)'s Messages")
        }
        
        print(messages.count)
        messages.sort(by: { (message1, message2) -> Bool in
            let date1 = message1.createdAt! as Date
            let date2 = message2.createdAt! as Date
            return date1 < date2
        })

        store.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        print("GETTING CALLED")
        
        store.fetchData()
        messages = recipient?.messages!.allObjects as! [Message]
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("MESSAGES: \(messages.count)")
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        let eachMessage = messages[indexPath.row]
        
        cell.textLabel?.text = eachMessage.content

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addmessageSegue" {
            if let destVC = segue.destination as? AddMessageViewController {
                destVC.recipient = self.recipient
            }
        }
    }
    
}
