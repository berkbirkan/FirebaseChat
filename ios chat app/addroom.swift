//
//  addroom.swift
//  ios chat app
//
//  Created by berk birkan on 5.10.2017.
//  Copyright © 2017 berk birkan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class addroom: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var addimage: UIImageView!
    
    @IBOutlet weak var groupname: UITextField!
    var uuid = NSUUID().uuidString
    
    @IBAction func creategroup(_ sender: UIButton) {
        let groupimagefolder = Storage.storage().reference().child("groupimage")
        if let data = UIImageJPEGRepresentation(addimage.image!, 0.5){
            groupimagefolder.child("\(uuid).jpg").putData(data, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    let alert = UIAlertController(title: "error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    let okbutton = UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let imageurl = metadata?.downloadURL()?.absoluteString
                    let creategroup = ["groupimage" : imageurl!,"createdby" : Auth.auth().currentUser?.email , "uuid" : self.uuid , "groupname": self.groupname.text] as [String : Any]
                    //Database.database().reference().child("groups").childByAutoId().setValue(creategroup)
                    Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("groups").childByAutoId().setValue(creategroup)
                    
                }
            })
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addimage.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(addroom.uploadimage))
        addimage.addGestureRecognizer(recognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func uploadimage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        addimage.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
   

}
