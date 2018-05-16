//
//  DashboardViewController.swift
//  tag
//
//  Created by Michael Brown on 5/15/18.
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

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    var imageURLString = " "
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://elimination.azurewebsites.net/api/Players/GetPlayerInfo?email=" + email!
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //check err
            //check response status 200 ok
            
            guard let data = data else {return}
            
            do {
                let login = try JSONDecoder().decode(Login.self, from: data)
                print(login)
                self.userNameLabel.text = login.UserName
                self.imageURLString = login.PhotoUrl
                let imageUrl = URL(string: self.imageURLString)
                let imageData = try! Data(contentsOf: imageUrl!)
                self.profilePicImageView.image = UIImage(data: imageData)
                
                print(self.imageURLString)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
            }.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
