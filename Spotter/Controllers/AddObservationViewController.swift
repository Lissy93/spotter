//
//  AddObservationViewController.swift
//  Spotter
//
//  Created by Alicia Sykes on 25/11/2015.
//  Copyright © 2015 Alicia Sykes. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class AddObservationViewController : UIViewController{

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtObservationName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @IBAction func savePressed(sender: UIButton) {
        if txtUsername.text == "" ||
            txtObservationName.text == "" ||
            txtDescription.text == "" ||
            txtLatitude.text == "" ||
            txtLongitude.text == "" ||
            txtCategory.text == ""{
                showDialog("Error", message: "Text fields can not be empty")
        }
        else{
            addObservationRequest(
                txtUsername.text!,
                name: txtObservationName.text!,
                description: txtDescription.text!,
                date: NSDate().description,
                latitude: txtLatitude.text!,
                longitude: txtLongitude.text!,
                category: txtCategory.text!
            )
        }
    }
    
    
    
    @IBAction func uploadLaterPressed(sender: UIButton) {
        if txtUsername.text == "" ||
            txtObservationName.text == "" ||
            txtDescription.text == "" ||
            txtLatitude.text == "" ||
            txtLongitude.text == "" ||
            txtCategory.text == ""{
                showDialog("Error", message: "Text fields can not be empty")
        }
        else{
            saveObservationInCoreData(
                txtUsername.text!,
                name: txtObservationName.text!,
                description: txtDescription.text!,
                date: NSDate().description,
                latitude: txtLatitude.text!,
                longitude: txtLongitude.text!,
                category: txtCategory.text!
            )
        }
        
        
        
    }

    
    
    func showDialog(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss",
            style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func addObservationRequest(
        username: String, name: String, description: String, date: String,
        latitude: String, longitude: String, category: String){
            
        let request = NSMutableURLRequest(URL: NSURL(string:
            "http://sots.brookes.ac.uk/~p0073862/services/obs/observations")!)
        request.HTTPMethod = "POST"
        let postString = "username="+username+"&name="+name+"&description="+description+"&date="+date+"&latitude="+latitude+"&longitude="+longitude+"&category="+category
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
    
    
    func saveObservationInCoreData(
        username: String, name: String, description: String, date: String,
        latitude: String, longitude: String, category: String){
    
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            let entity =  NSEntityDescription.entityForName("ObservationsData",
                inManagedObjectContext:managedContext)
            
            let observationData = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext: managedContext)
            
            observationData.setValue(username, forKey: "username")
            observationData.setValue(name, forKey: "name")
            observationData.setValue(description, forKey: "desc")
            observationData.setValue(date, forKey: "date")
            observationData.setValue(latitude, forKey: "latitude")
            observationData.setValue(longitude, forKey: "longitude")
            observationData.setValue(category, forKey: "category")
            
            do {
                try managedContext.save()
                requestWasSuccesful()
            } catch let error as NSError  {
                requestWasFailed("Error Saving Observation: "+error.description)
            }
            
            
    
    
    }
    
    
    
    
    func requestWasSuccesful(){
        showDialog("Success", message: "Observation Saved!") // Show success dialog
        
        // Reset text fields
        txtUsername.text = ""
        txtObservationName.text = ""
        txtDescription.text = ""
        txtLatitude.text = ""
        txtLongitude.text = ""
        txtCategory.text = ""
        
    }
    
    func requestWasFailed(message:String){
        showDialog("Error", message: message)
    }
    
    


}
