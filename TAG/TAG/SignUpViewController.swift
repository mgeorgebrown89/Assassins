//
//  SignUpViewController.swift
//  tag
//
//  Created by Michael Brown on 4/27/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var signUpEmailField: UITextField!
    @IBOutlet weak var signUpPasswordField: UITextField!
    @IBOutlet weak var signUpConfirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let createAccountVC = segue.destination as? CreateAccountViewController {
            createAccountVC.email = signUpEmailField.text!
            createAccountVC.password = signUpPasswordField.text!
            createAccountVC.confirmPassword = signUpConfirmPasswordField.text!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
