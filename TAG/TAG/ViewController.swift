//
//  ViewController.swift
//  Assassins
//
//  Created by Michael Brown on 3/3/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

struct login {
    let email: String
    let password: String
}

struct register {
    let FirstName: String
    let LastName: String
    let DOB: String
    let UserName: String
    let Email: String
    let Phone: String
    let PhotoUrl: String
    let Profile: String
    let Password: String
    let ConfirmPassword: String    
}

class ViewController: UIViewController, UITextFieldDelegate {

    //*****login*****//
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //*****register*****//
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var DOBtextField: UITextField!
    
    //***** *****//
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //*****login*****//
    @IBAction func submitLogin(_ sender: UIButton) {
        let newLogin = login(email: emailTextField.text!, password: passwordTextField.text!)
        print(newLogin)
    }
    //*****register*****//
    
    @IBAction func submitRegistration(_ sender: Any) {
        let newRegistration = register(FirstName: firstNameTextField.text!, LastName: lastNameTextField.text!, DOB: DOBtextField.text!, UserName: usernameTextField.text!, Email: registerEmailTextField.text!, Phone: phoneTextField.text!, PhotoUrl: "", Profile: "", Password: registerPasswordTextField.text!, ConfirmPassword: registerConfirmPasswordTextField.text!)
        
        print(newRegistration)
        
        let jsonUrlString = "https://elimination.azurewebsites.net/api/Account/Post"
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            
            //check 200 status ok
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
