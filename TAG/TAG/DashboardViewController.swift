//
//  DashboardViewController.swift
//  tag
//
//  Created by Michael Brown on 5/15/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    var imageURLString = "https://eliminationimages.blob.core.windows.net/ldskfj/ldskfj.jpeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageUrl = URL(string: imageURLString)
        
        let imageData = try? Data(contentsOf: imageUrl!)
        
        profilePicImageView.image = UIImage(data: imageData!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
