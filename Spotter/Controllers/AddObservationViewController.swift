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

class AddObservationViewController : UIViewController, ObservationRequest{

    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtObservationName: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    
    var manageObservations: ManageObservations = ManageObservations(this: UIViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageObservations = ManageObservations(this: self as UIViewController)

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
                manageObservations.showDialog("Error", message: "Text fields can not be empty")
        }
        else{
            manageObservations.addObservationRequest(
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
                manageObservations.showDialog("Error", message: "Text fields can not be empty")
        }
        else{
            manageObservations.saveObservationInCoreData(
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

    
    func success(){
        // Reset text fields
        txtUsername.text = ""
        txtObservationName.text = ""
        txtDescription.text = ""
        txtLatitude.text = ""
        txtLongitude.text = ""
        txtCategory.text = ""
    }

}
