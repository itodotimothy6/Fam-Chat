//
//  ChatViewController.swift
//  Fam-Chat
//
//  Created by Timothy Itodo on 5/17/19.
//  Copyright © 2019 Timothy Itodo. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate  {
    
    var messageArray : [Message] = [Message]()

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegate and datasource of UITable
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        // Delegate of the text field
        messageTextField.delegate = self
        
        // tapGesture to make keyboard go down after typing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        // Register CustomMessageCell.xib file
        messageTableView.register(UINib(nibName: "CustomMessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        retrieveMessages()
        
        messageTableView.separatorStyle = .none
    }
    
    
    ///////////////////////////////////////////
    // MARK:- TableView DataSource Methods
    
    // cellForRowAtIndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String? { // Messages current user sent
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
        }
        else { // Messages others sent
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            cell.messageBackground.backgroundColor = UIColor.flatGreen()
        }
        
        return cell
    }
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    // tableViewTapped function for tap gesture
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }
    
    /* configureTableView: supposed to ensure messagebody increases automatically
     * if text is too much
     */
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    ///////////////////////////////////////////
    //MARK:- TextField Delegate Methods
    
    //textFieldDidBeginEditing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    // textFieldDidEndEditing
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 65
            self.view.layoutIfNeeded()
        }
    }
    
    ///////////////////////////////////////////
    //MARK: - Send & Recieve from Firebase

    @IBAction func sendButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        messageTextField.endEditing(true)
        
        // Send the message to Firebase and save in database
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MessageBody" : messageTextField.text]
        
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else {
                print("Message sent successfully")
                SVProgressHUD.dismiss()
                
                self.messageTextField.text = ""
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
            }
        }
    }
    
    func retrieveMessages() {
        SVProgressHUD.show()
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let message = Message()
            message.sender = snapshotValue["Sender"]!
            message.messageBody = snapshotValue["MessageBody"]!
            
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
            print("Message retrieved")
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        do {
            try Auth.auth().signOut()
            
            SVProgressHUD.dismiss()
            
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("error signing out.")
        }
    }
    
}
