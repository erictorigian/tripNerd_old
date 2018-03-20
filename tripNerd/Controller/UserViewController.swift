//
//  UserViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/20/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var usernames = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get data from parse and update the array
        let query = PFUser.query()
        
        query?.whereKey("username", notEqualTo: PFUser.current()?.username!)
        
        query?.findObjectsInBackground(block: { (users, error) in
            if error != nil {
                
                print(error!)
                
            } else {
                self.usernames.removeAll()
                
                if let users = users {
                    
                    for object in users {
                        
                        if let user = object as? PFUser {
                            
                            if let username = user.username {
                                
                                self.usernames.append(username)
                            }
                        }
                    }
                
            }
                self.tableView.reloadData()
                
            }
            
        })
        
    }

    
    //MARK: - tableview functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        cell.detailTextLabel?.text = "details"
        cell.textLabel?.text = usernames[indexPath.row]
        
        return cell
        
    }

}
