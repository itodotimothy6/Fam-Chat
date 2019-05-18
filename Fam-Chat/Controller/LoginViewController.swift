//
//  LoginViewController.swift
//  Fam-Chat
//
//  Created by Timothy Itodo on 5/17/19.
//  Copyright © 2019 Timothy Itodo. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        SVProgressHUD.show()
        // Log in the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("Error")
            }
            else {
                print("Log in successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
    
}
