//
//  ViewController.swift
//  Assassins
//
//  Created by Michael Brown on 3/3/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


//***** login struct for JSON objects *****//
struct login {
    let email: String
    let password: String
}

//***** register struct for JSON objects *****//
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

class ViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //***** login fields *****//
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //***** register fields *****//
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var DOBtextField: UITextField!
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    
    //***** *****//
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//**************** Camera & Photos *********************//
    
    @IBAction func takePhotoButton(_ sender: Any) {
        //******** Camera **************//
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch cameraAuthorizationStatus {
        case .notDetermined: requestCameraPermission()
        case .authorized: presentCamera()
        case .restricted, .denied: alertCameraAccessNeeded()
        }
    }

    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in guard accessGranted == true else {return}
            self.presentCamera()
        })
    }
    
    func presentCamera() {
        let photoPicker = UIImagePickerController()
        photoPicker.sourceType = .camera
        photoPicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        //removed "?" after self as
        
        self.present(photoPicker, animated: true, completion: nil)
    }

    func alertCameraAccessNeeded() {
        let settingsAppURL = URL(string: UIApplicationOpenSettingsURLString)!
        
        let alert = UIAlertController(
            title: "Need Camera Access",
            message: "Camera access is required to make full use of this app.",
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        // do something with the photo... set to UIImageView, save it, etc.
        
        profilePicImageView.image = photo
        dismiss(animated: true, completion: nil)
    }
    
//**********************************************************************//
//****************************** Login *********************************//
//**********************************************************************//
    @IBAction func submitLogin(_ sender: UIButton) {
        let newLogin = login(email: emailTextField.text!, password: passwordTextField.text!)
        print(newLogin)
        
        
    }
//**********************************************************************//
//****************************** Register ******************************//
//**********************************************************************//
    
    //func submitPost from Saoud M. Rizwan at medium.com
    func submitPost(post: register, completion:((Error?) -> Void)?) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "elimination.azurewebsites.net"
        urlComponents.path = "/api/Account/Post"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // include headers specifying the request's HTTP body will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // encode Post struct into JSON data...
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(post)
            // ... and set our request's HTTP body
            request.httpBody = jsonData
           print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run a URLSession data task with JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!)
                return
            }
            
            // APIs usually respond with the data sent in POST request
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    
    
    @IBAction func submitRegistration(_ sender: Any) {

        let jpgProfile = UIImageJPEGRepresentation(profilePicImageView.image!, 0.0)
        let base64String = jpgProfile!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: UInt(0.1)))

        let newRegistration = register(FirstName: firstNameTextField.text!, LastName: lastNameTextField.text!, DOB: DOBtextField.text!, UserName: usernameTextField.text!, Email: registerEmailTextField.text!, Phone: phoneTextField.text!, Photo: base64String, PhotoExtension: ".jpg", Profile: "test", Password: registerPasswordTextField.text!, ConfirmPassword: registerConfirmPasswordTextField.text!)
        //print(newRegistration)
        submitPost(post: newRegistration) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
