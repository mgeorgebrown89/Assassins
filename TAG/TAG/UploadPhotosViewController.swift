//
//  UploadPhotosViewController.swift
//  tag
//
//  Created by Michael Brown on 4/27/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit

struct register: Codable {
    let Email: String
    let Password: String
    let ConfirmPassword: String
    let UserName: String
    let FirstName: String
    let LastName: String
    let DOB: String
    let Phone: String
    let Profile: String
    let Photo: String
    let PhotoExtension : String
}

class UploadPhotosViewController: UIViewController {

    var email: String?
    var password: String?
    var confirmPassword: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var DOB: String?
    var phone: String?
    var motto: String?
    
    var leftPhoto: String?
    var profilePhoto: String?
    var rightPhoto: String?
    
    
    
    @IBOutlet weak var leftPhotoImageField: UIImageView!
    @IBOutlet weak var middlePhotoImageView: UIImageView!
    @IBOutlet weak var rightPhotoImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func leftPhotoUpload(_ sender: Any) {
        leftPhoto = convertPhotoToBase64(image: leftPhotoImageField.image!)
    }
    
    @IBAction func middlePhotoTapped(_ sender: Any) {
    }
    
    @IBAction func rightPhotoTapped(_ sender: Any) {
    }
    
    private func convertPhotoToBase64(image: UIImage) -> String{
        let jpgPhoto = UIImageJPEGRepresentation(image, 0.0)
        let base64String = jpgPhoto!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: UInt(0.1)))
        return base64String
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let newRegistration = register(Email: email!, Password: password!, ConfirmPassword: confirmPassword!, UserName: userName!, FirstName: firstName!, LastName: lastName!, DOB: DOB!, Phone: phone!, Profile: motto!, Photo: "photo here", PhotoExtension: ".jpg")
        print(newRegistration)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
