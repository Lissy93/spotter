
import UIKit
import CoreData
import Foundation

class ViewObservationsViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    
    // Parser variables
    var parser = NSXMLParser()
    var observations = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    let baseUrl = "http://sots.brookes.ac.uk/~p0073862/services/obs"
    var urlExt = ""
    
    
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
            cell?.textLabel!.font = UIFont (name: "HelveticaNeue-UltraLight", size: 20)
            cell!.textLabel!.text = (observations[indexPath.row] as! Observation).description
            return cell!
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let pressedObservation: Observation = (observations[indexPath.row] as! Observation)
        let alert = UIAlertController(title: "Observation: "+pressedObservation.name,
            message: "Description: "+pressedObservation.description+"\n Recorded By: "+pressedObservation.username+" \n Date: "+pressedObservation.date + "\n Location: "+pressedObservation.latitude+","+pressedObservation.longitude+" \n Category: "+pressedObservation.category,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    
    }
    
    
    func getObservationsRequest(){
        let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+urlExt)!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if (error == nil) {
                let parser = XMLParser(data: data!)
                if (parser.parse()) {
                    let rootElement = parser.rootElement!
                    for subElement in rootElement.subElements {
                        
                        var username = ""
                        var name = ""
                        var description = ""
                        var date = ""
                        var latitude = ""
                        var longitude = ""
                        var category = ""
                        
                        for element in subElement.subElements {
                            
                            switch element.name! {
                                
                            case "username":
                                if let _ = element.text {
                                    username = element.text!
                                }
                            case "latitude" :
                                latitude = element.text!
                            case "longitude" :
                                longitude = element.text!
                            case "date":
                                if let _ = element.text {
                                    date = element.text!
                                }
                            case "name":
                                if let _ = element.text {
                                    name = element.text!
                                }
                            case "description":
                                if let _ = element.text {
                                    description = element.text!
                                }
                            case "category":
                                if let _ = element.text {
                                    category = element.text!
                                }
                                
                            default:
                                ()
                                
                            }
                        }
                        let observation = Observation(username: username, name: name,
                            description: description, date: date, latitude: latitude,
                            longitude: longitude, category: category)
                        
                        self.observations.addObject(observation)

                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.tableView.reloadData()
                }
            }
        }
        
        task.resume()
        
    }
    
}










