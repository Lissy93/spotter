//
//  RegisterUserViewController.swift
//  Spotter
//
//  Created by Alicia Sykes on 25/11/2015.
//  Copyright © 2015 Alicia Sykes. All rights reserved.
//

import Foundation
import UIKit


class RegisterUserViewController : UIViewController {
    
    @IBOutlet weak var txtFullname: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePressed(sender: UIButton) {
        if txtFullname.text == "" || txtUsername.text == "" {
            showDialog("Error", message: "Please enter a valid name and username")
            
        }
        
    }
    
    func showDialog(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss",
            style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

