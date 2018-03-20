//
//  NewPostViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/20/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse

class NewPostViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func PostButtonPressed(_ sender: Any) {
        
        if statusTextField.text != "" {
            let post = PFObject(className: "Posts")
            
            post["statusText"] = statusTextField.text
            post["username"] = PFUser.current()?.username
            
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
    
}
