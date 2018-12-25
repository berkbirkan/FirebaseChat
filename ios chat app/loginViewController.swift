//
//  loginViewController.swift
//  ios chat app
//
//  Created by berk birkan on 4.10.2017.
//  Copyright © 2017 berk birkan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class loginViewController: UIViewController {
    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var passtext: UITextField!
    
    @IBAction func signinbutton(_ sender: UIButton) {
        if emailtext.text != "" && passtext.text != "" {
            Auth.auth().signIn(withEmail: emailtext.text!, password: passtext.text!, completion: { (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okbutton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert, animated: true , completion: nil)
                }else{
                    //self.performSegue(withIdentifier: "totabbar", sender: nil)
                    UserDefaults.standard.set(user!.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberlogin()
                }
            })
        }else{
            let alert = UIAlertController(title: "Error", message: "email and pass required", preferredStyle: UIAlertControllerStyle.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okbutton)
            self.present(alert, animated: true , completion: nil)
        }
        
    }
    
    @IBAction func signupbutton(_ sender: UIButton) {
        if emailtext.text != "" && passtext.text != "" {
            Auth.auth().createUser(withEmail: emailtext.text!, password: passtext.text!, completion: { (user, error) in
                if error != nil{
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okbutton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert, animated: true , completion: nil)
                }else {
                    UserDefaults.standard.set(user!.email, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberlogin()
                }
            })
        } else {
            let alert = UIAlertController(title: "Error", message: "email and pass required", preferredStyle: UIAlertControllerStyle.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okbutton)
            self.present(alert, animated: true , completion: nil)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
