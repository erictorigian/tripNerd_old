//
//  NewPostViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/20/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class NewPostViewController: UIViewController, CLLocationManagerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var lastLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    @IBAction func chooseAnImageButtonPressed(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = image
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    @IBAction func PostButtonPressed(_ sender: Any) {
        
        if statusTextField.text != "" {
            let post = PFObject(className: "Posts")
            
            let point = PFGeoPoint(location: lastLocation )
            
            let imageData = UIImagePNGRepresentation(imageView.image!)
            let imageFile = PFFile(name: "Image File", data: imageData!)!
            
            
            post["statusText"] = statusTextField.text
            post["username"] = PFUser.current()?.username
            post["location"] = point
            post["imageFile"] = imageFile
            
            post.saveInBackground { (success, error) in
                if error != nil {
                    print(error!)
                } else {
                    print("Saved")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastLocation = locations[0]
    }
    
}
