//
//  ViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/14/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse

let user = PFUser()
var currentUser = PFUser.current()


class SignInViewController: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            self.performSegue(withIdentifier: "showMainView", sender: nil)
        }
    }
    
    //MARK: - IBActions
    @IBAction func logOnButtonPressed(_ sender: Any) {
        if userNameTextField.text == "" || passwordTextField.text == "" {
            self.showAlert(title: "Error in Form", message: "You must include both a username and password to login")
            
        } else {
            if currentUser != nil {
                performSegue(withIdentifier: "showMainView", sender: nil)
            } else {
                //login the user
                PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if error == nil {
                        //logged in
                        currentUser = user
                        self.performSegue(withIdentifier: "showMainView", sender: nil)
                    } else  {
                        //error logging in
                        self.showAlert(title: "Error Logging into TripNerd", message: (error?.localizedDescription)!)
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
