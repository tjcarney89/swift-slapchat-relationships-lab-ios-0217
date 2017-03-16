//
//  AddRecipientViewController.swift
//  SlapChat
//
//  Created by TJ Carney on 3/16/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit

class AddRecipientViewController: UIViewController {
    
    @IBOutlet weak var recipientNameTextField: UITextField!
    @IBOutlet weak var recipientEmailTextField: UITextField!
    @IBOutlet weak var recipientPhoneTextField: UITextField!
    @IBOutlet weak var recipientTwitterTextField: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if !recipientNameTextField.hasText || !recipientEmailTextField.hasText || !recipientPhoneTextField.hasText || !recipientTwitterTextField.hasText {
            let myAlert = UIAlertController(title: "Fields Empty", message: "All Fields Required", preferredStyle: .alert)
            let myAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(myAction)
            self.present(myAlert, animated: true)

        } else {
            let store = DataStore.sharedInstance
            let context = store.persistentContainer.viewContext
            let newRecipient = Recipient(context: context)
            if let name = recipientNameTextField.text {
                newRecipient.name = name
            }
            if let email = recipientEmailTextField.text {
                newRecipient.email = email
            }
            if let phone = recipientPhoneTextField.text {
                newRecipient.phoneNumber = phone
            }
            if let twitter = recipientTwitterTextField.text {
                newRecipient.twitterHandle = twitter
            }
            store.saveContext()
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
