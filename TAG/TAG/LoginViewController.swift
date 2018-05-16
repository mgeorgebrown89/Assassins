//
//  LoginViewController.swift
//  tag
//
//  Created by Michael Brown on 4/26/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

struct Login: Decodable {
    let PlayerID: Int
    let FirstName: String
    let LastName: String
    let UserName: String
    let Email: String
    let Phone: String
    let DOB: String
    let PhotoUrl: String
    let Profile: String
    let AuthUserID: String
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    var email: String?
    var userName: String?
    var photo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //move json stuff to the dashboard. just pass email from here
    
    func submitGet(email: String){
        let jsonUrlString = "https://elimination.azurewebsites.net/api/Players/GetPlayerInfo?email=" + email
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            //check response status 200 ok
            
            guard let data = data else {return}
            
            do {
                let login = try JSONDecoder().decode(Login.self, from: data)
                print(login)
                self.userName = login.UserName
                self.photo = login.PhotoUrl
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        email = loginEmailField.text!
        submitGet(email: email!)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let dashboardControllerVC = segue.destination as? DashboardViewController {
//            dashboardControllerVC.userNameLabel?.text = userName
//            dashboardControllerVC.imageURLString = photo!
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

