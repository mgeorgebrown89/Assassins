//
//  CreateAccountViewController.swift
//  tag
//
//  Created by Michael Brown on 4/27/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    var email: String?
    var password: String?
    var confirmPassword: String?
    @IBOutlet weak var createAccountUserNameField: UITextField!
    @IBOutlet weak var createAccountFirstNameField: UITextField!
    @IBOutlet weak var createAccountLastNameField: UITextField!
    @IBOutlet weak var createAccountDOBField: UITextField!
    @IBOutlet weak var createAccountPhoneField: UITextField!
    @IBOutlet weak var createAccountMottoField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let uploadPhotosVC = segue.destination as? UploadPhotosViewController {
            
            uploadPhotosVC.email = email!
            uploadPhotosVC.password = password!
            uploadPhotosVC.confirmPassword = confirmPassword!
            
            uploadPhotosVC.userName = createAccountUserNameField.text!
            uploadPhotosVC.firstName = createAccountFirstNameField.text!
            uploadPhotosVC.lastName = createAccountLastNameField.text!
            uploadPhotosVC.DOB = createAccountDOBField.text!
            uploadPhotosVC.phone = createAccountPhoneField.text!
            uploadPhotosVC.motto = createAccountMottoField.text!
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
