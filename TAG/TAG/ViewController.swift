//
//  ViewController.swift
//  Assassins
//
//  Created by Michael Brown on 3/3/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var emailAddress: String = ""
    var passwordEntry: String = ""
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var testLabelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitLogin(_ sender: UIButton) {
        emailAddress = emailTextField.text!
        passwordEntry = passwordTextField.text!
        testLabelName.text = emailAddress
    }
}
