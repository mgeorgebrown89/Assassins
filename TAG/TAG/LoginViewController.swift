//
//  LoginViewController.swift
//  tag
//
//  Created by Michael Brown on 4/26/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        email = loginEmailField.text!
        password = loginPasswordField.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dashboardControllerVC = segue.destination as? DashboardViewController {
            dashboardControllerVC.email = email
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

