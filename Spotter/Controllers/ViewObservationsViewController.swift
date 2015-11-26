

import UIKit
import CoreData
import Foundation

class ViewObservationsViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    var observations = [String]()
    var currentElement:String = ""
    var passData:Bool=false
    var passName:Bool=false
    var parser = NSXMLParser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getObservationsRequest()
        tableView.delegate = self
        tableView.dataSource = self;
        title = "All Observations"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return observations.count
    }
    
    
    // Generates a cell for each user and adds to tableview
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            cell?.textLabel!.text = observations[indexPath.row] as?String
            cell?.textLabel!.font = UIFont (name: "HelveticaNeue-UltraLight", size: 20)
            return cell!
    }
    
        func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            currentElement="";
            if(elementName=="username" || elementName=="name" || elementName=="description" || elementName=="date" || elementName=="latitude" || elementName=="longitude" || elementName=="category")
            {
                if(elementName=="name"){
                    passName=false;
                }
                passData=false;
            }
            passData = true
        }
    
        func parser(parser: NSXMLParser, foundCharacters string: String?) {
            if(passData){
                observations.append(string!)
            }
        }
    
        func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
            NSLog("failure error: %@", parseError)
        }
    
    
        func getObservationsRequest(){
            let request = NSMutableURLRequest(URL: NSURL(string:
                "http://sots.brookes.ac.uk/~p0073862/services/obs/observations")!)
    
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
    
    
                let parser = NSXMLParser(data: data!)
                parser.delegate = self
                parser.parse()
    
                print(self.observations)
    
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
            }
            task.resume()
            
        }
    

    
    
    
    
    
}





























////
////  ViewObservationsViewController.swift
////  Spotter
////
////  Created by Alicia Sykes on 25/11/2015.
////  Copyright © 2015 Alicia Sykes. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class ViewObservationsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    var strXMLData:String = ""
//    var currentElement:String = ""
//    var passData:Bool=false
//    var passName:Bool=false
//    var parser = NSXMLParser()
//    var observationNames = [String]()
//
//    var items: [String] = ["We", "Heart", "Swift"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self;
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        getObservationsRequest()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
//        cell.textLabel?.text = self.items[indexPath.row]
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
//
//    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        currentElement="";
//        if(elementName=="username" || elementName=="name" || elementName=="description" || elementName=="date" || elementName=="latitude" || elementName=="longitude" || elementName=="category")
//        {
//            if(elementName=="name"){
//                passName=false;
//            }
//            passData=false;
//        }
//        passData = true
//    }
//    
//    func parser(parser: NSXMLParser, foundCharacters string: String?) {
//        if(passName){
//            strXMLData=strXMLData+"\n\n"+string!
//        }
//        
//        if(passData){
//            observationNames.append(string!)
//        }
//    }
//    
//    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
//        NSLog("failure error: %@", parseError)
//    }
//    
//
//    func getObservationsRequest(){
//        let request = NSMutableURLRequest(URL: NSURL(string:
//            "http://sots.brookes.ac.uk/~p0073862/services/obs/observations")!)
//
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
//            data, response, error in
//            
//            
//            let parser = NSXMLParser(data: data!)
//            parser.delegate = self
//            parser.parse()
//            
//            print(self.strXMLData)
//            
//            dispatch_async(dispatch_get_main_queue()) { () -> Void in
//
//                                
//            }
//        }
//        task.resume()
//        
//    }
//
//    
//    
//
//}
