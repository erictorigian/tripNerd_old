//
//  signUpViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/19/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
        if usernameTextField.text != nil {
            if emailTextField.text != nil {
                if passwordTextField.text == passwordConfirmationTextField.text  {
                    let user = PFUser()
                    
                    user.username = usernameTextField.text
                    user.password = passwordTextField.text
                    user.email = emailTextField.text
                    
                    user.signUpInBackground { (success, error) in
                        if error == nil {
                            self.performSegue(withIdentifier: "cancelSignUp", sender: nil)
                        } else {
                            self.showAlert(title: "Error", message: (error?.localizedDescription)!)
                        }
                    }
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
