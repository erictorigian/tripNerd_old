//
//  ViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/14/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    
        let patientRecords = PFObject(className: "PatientRecords")
        
        patientRecords["name"] = "Eric"
        patientRecords["address"] = "96 Stillmeadown lane"
        patientRecords["balance"] = 100
        
        patientRecords.saveInBackground { (success, error) in
            if error == nil {
                print("record saved")
            } else {
                print(error!)
            }
        }
        
        
    }

}

