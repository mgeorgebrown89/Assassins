//
//  UploadPhotosViewController.swift
//  tag
//
//  Created by Michael Brown on 4/27/18.
//  Copyright © 2018 The Elimination Framework. All rights reserved.
//

import UIKit
import AVFoundation

//struct for JSON
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

struct Player: Codable {
    let PlayerID: Int
}

class UploadPhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //stuff from registration
    var email: String?
    var password: String?
    var confirmPassword: String?
    var userName: String?
    var firstName: String?
    var lastName: String?
    var DOB: String?
    var phone: String?
    var motto: String?
    
    //photo fields
    @IBOutlet weak var leftPhotoImageField: UIImageView!
    @IBOutlet weak var middlePhotoImageView: UIImageView!
    @IBOutlet weak var rightPhotoImageView: UIImageView!
    ///a var for which photo is being uploaded
    var whichPhoto = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    ///photos converting to base64
    @IBAction func leftPhotoUpload(_ sender: Any) {
        whichPhoto = 0
        openCamera()
    }
    @IBAction func middlePhotoTapped(_ sender: Any) {
        whichPhoto = 1
        openCamera()
    }
    @IBAction func rightPhotoTapped(_ sender: Any) {
        whichPhoto = 2
        openCamera()
    }
    
    ///This function opens the camera
    func openCamera(){
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
        photoPicker.cameraDevice = .front
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
        /// determine which photo is being uploaded
        switch whichPhoto {
        case 0: leftPhotoImageField.image = photo
        case 1: middlePhotoImageView.image = photo
        case 2: rightPhotoImageView.image = photo
        default:
            return
        }
        dismiss(animated: true, completion: nil)
    }
    
    ///convert to jpeg, then base64
    private func convertPhotoToBase64(image: UIImage) -> String{
        let jpgPhoto = UIImageJPEGRepresentation(image, 0.0)
        let base64String = jpgPhoto!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: UInt(0.1)))
        return base64String
    }
    
    ///submit JSON post to register
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
                let decoder = JSONDecoder()
                let player = try! decoder.decode(Player.self, from: data)
                print(player.PlayerID)
                print("response: ", utf8Representation)
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let newRegistration = register(Email: email!, Password: password!, ConfirmPassword: confirmPassword!, UserName: userName!, FirstName: firstName!, LastName: lastName!, DOB: DOB!, Phone: phone!, Profile: motto!, Photo: convertPhotoToBase64(image: middlePhotoImageView.image!), PhotoExtension: ".jpg")
        print(newRegistration)
        submitPost(post: newRegistration) { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
