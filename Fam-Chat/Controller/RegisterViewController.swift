//
//  RegisterViewController.swift
//  Fam-Chat
//
//  Created by Timothy Itodo on 5/17/19.
//  Copyright © 2019 Timothy Itodo. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        
        //Set up a new user on our Firbase database
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("Registration Error:\n \(error!)")
                SVProgressHUD.dismiss()
            }
            else {// success
                print("Registration successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }

}
