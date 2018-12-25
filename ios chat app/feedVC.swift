//
//  FirstViewController.swift
//  ios chat app
//
//  Created by berk birkan on 4.10.2017.
//  Copyright © 2017 berk birkan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class feedVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var useremailarray = [String]()
    var groupnamearray = [String]()
    var imageurlarray = [String]()
    
    
    @IBAction func logoutbutton(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let signin = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.rootViewController = signin
        
        delegate.rememberlogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        getDataFromServer()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useremailarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.groupname.text = groupnamearray[indexPath.row]
        cell.createdby.text = useremailarray[indexPath.row]
        cell.groupimage.sd_setImage(with: URL(string:self.imageurlarray[indexPath.row]))
        return cell
    }
    
    func getDataFromServer(){
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            
            let values = snapshot.value! as! NSDictionary
            let group = values["groups"] as! NSDictionary
            let groupids = group.allKeys
            for id in groupids{
                let singlegroup = group[id] as! NSDictionary
                self.useremailarray.append(singlegroup["createdby"] as! String)
                self.groupnamearray.append(singlegroup["groupname"] as! String)
                self.imageurlarray.append(singlegroup["groupimage"] as! String)
                
            }
            self.tableview.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

