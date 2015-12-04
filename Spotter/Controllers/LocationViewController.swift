//
//  LocationViewController.swift
//  Spotter
//
//  Created by Alicia Sykes on 03/12/2015.
//  Copyright © 2015 Alicia Sykes. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class LocationViewController: UIViewController{

    
    @IBOutlet var mapView: MKMapView!
    
    var observationsList = NSMutableArray()
    
    override func viewDidLoad() {
        
        for eachObservation in observationsList{
            let observation = eachObservation as! Observation
            let location = CLLocationCoordinate2D(latitude: Double(observation.latitude)!, longitude: Double(observation.longitude)!)
            let anotation = MKPointAnnotation()
            anotation.coordinate = location
            anotation.title = "The Location"
            anotation.subtitle = "This is the location !!!"
            mapView.addAnnotation(anotation)
        }
        
    }


}
