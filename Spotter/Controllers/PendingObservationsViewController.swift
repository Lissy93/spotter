//
//  PendingObservationsViewController.swift
//  Spotter
//
//  Created by Alicia Sykes on 07/12/2015.
//  Copyright © 2015 Alicia Sykes. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PendingObservationsViewController : UIViewController, UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    
    var observations = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pending Observations"
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func uploadObservationsPressed(sender: UIButton) {
        
        
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return observations.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            
            let person = observations[indexPath.row]
            
            cell!.textLabel!.text =
                person.valueForKey("name") as? String
            
            return cell!
    }


}