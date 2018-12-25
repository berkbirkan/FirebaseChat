//
//  SecondViewController.swift
//  ios chat app
//
//  Created by berk birkan on 4.10.2017.
//  Copyright © 2017 berk birkan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

