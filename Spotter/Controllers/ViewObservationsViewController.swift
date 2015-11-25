//
//  ViewObservationsViewController.swift
//  Spotter
//
//  Created by Alicia Sykes on 25/11/2015.
//  Copyright © 2015 Alicia Sykes. All rights reserved.
//

import Foundation
import UIKit

class ViewObservationsViewController : UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getObservationsRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func getObservationsRequest(){
        let request = NSMutableURLRequest(URL: NSURL(string:
            "http://sots.brookes.ac.uk/~p0073862/services/obs/observations")!)

        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(responseString)
            }
        }
        task.resume()
        
    }

    
    

}
