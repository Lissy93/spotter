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
        else{
            registerUserRequest(txtFullname.text!, username:txtUsername.text!)
        }
        
    }
    
    func showDialog(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss",
            style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func registerUserRequest(fullname: String, username: String){
        let request = NSMutableURLRequest(URL: NSURL(string:
            "http://sots.brookes.ac.uk/~p0073862/services/obs/register")!)
        request.HTTPMethod = "POST"
        let postString = "username="+username+"&name="+fullname
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in

            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in

                if(statusCode == 200){
                    self.requestWasSuccesful()
                }
                else{
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    self.requestWasFailed(responseString as! String)
                }
            
            }

        }
        task.resume()

    }
    
    func requestWasSuccesful(){
        showDialog("Success", message: "User was registered succesfully")
    
    }
    
    func requestWasFailed(message:String){
        showDialog("Error", message: message)
    }
}

