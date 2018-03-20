//
//  MainViewController.swift
//  tripNerd
//
//  Created by Eric Torigian on 3/20/18.
//  Copyright © 2018 Eric Torigian. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var postUpdates = [PFObject(className: "Posts")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Posts")
        
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                print(error!)
            } else if let posts = objects {
                self.postUpdates.removeAll()
                
                for object in posts {
                    self.postUpdates.append(object)
                }
                
                self.tableView.reloadData()
                
            }
        }
    }

    @IBAction func addPostButtonPressed(_ sender: Any) {
    }
    
    @IBAction func settingButtonPressed(_ sender: Any) {
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        PFUser.logOut()
        self.navigationController?.isNavigationBarHidden = true
        self.performSegue(withIdentifier: "backToLogin", sender: nil)
    }

    @IBAction func userButtonPressed(_ sender: Any) {
    }
    
    
    //MARK: - tableview functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postUpdates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "postCell")
        
        cell.detailTextLabel?.text = postUpdates[indexPath.row]["username"] as? String
        cell.textLabel?.text = postUpdates[indexPath.row]["statusText"] as? String
        
        return cell
    }
}
