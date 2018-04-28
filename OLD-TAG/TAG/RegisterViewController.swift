//
//  RegisterViewController.swift
//  TAG
//
//  Created by Michael Brown on 4/25/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit
import AVFoundation

/// Register struct for encoding to JSON object
struct register: Codable {
    let FirstName: String
    let LastName: String
    let DOB: String
    let UserName: String
    let Email: String
    let Phone: String
    let Photo: String
    let PhotoExtension : String
    let Profile: String
    let Password: String
    let ConfirmPassword: String
}

class RegisterViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitRegistration(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
