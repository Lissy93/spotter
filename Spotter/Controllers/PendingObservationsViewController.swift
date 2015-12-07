
import Foundation
import CoreData
import UIKit

class PendingObservationsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, ObservationRequest{


    @IBOutlet weak var tableView: UITableView!
    
    var manageObservations: ManageObservations = ManageObservations(this: UIViewController())
    
    var observations = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageObservations = ManageObservations(this: self as UIViewController)
        title = "Pending Observations"
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchObservationsFromCoreData()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
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
            
            let observation = observations[indexPath.row]
                        
            cell!.textLabel!.text =
                observation.valueForKey("name") as? String
            
            return cell!
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let pressedObservation = (observations[indexPath.row])
        let obs = Observation(
            username: pressedObservation.valueForKey("username") as! String,
            name: pressedObservation.valueForKey("name") as! String,
            description: pressedObservation.valueForKey("desc") as! String,
            date: pressedObservation.valueForKey("date") as! String,
            latitude: pressedObservation.valueForKey("latitude") as! String,
            longitude: pressedObservation.valueForKey("longitude") as! String,
            category: pressedObservation.valueForKey("category") as! String
        )
        let alert = UIAlertController(title: "Observation: "+obs.name,
            message: "Description: "+obs.description+"\n Recorded By: "+obs.username+" \n Date: "+obs.date + "\n Location: "+obs.latitude+","+obs.longitude+" \n Category: "+obs.category,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Upload", style: UIAlertActionStyle.Default, handler: {[weak self]
            (paramAction:UIAlertAction!) in self!.uploadObs(obs)
            self!.removeObsFromCoreData(indexPath)
            } ))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func fetchObservationsFromCoreData(){
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ObservationsData")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            observations = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func uploadObs(observation: Observation){
        manageObservations.addObservationRequest(
            observation.username,
            name: observation.name,
            description: observation.description,
            date: NSDate().description,
            latitude: observation.latitude,
            longitude: observation.longitude,
            category: observation.category
        )
    }
    
    func removeObsFromCoreData(indexPath: NSIndexPath){
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        context.deleteObject(observations[indexPath.row] as NSManagedObject)
        observations.removeAtIndex(indexPath.row)
        do{ try context.save() }
        catch let error as NSError { print("Error \(error)") }
    }

    func success() {
        fetchObservationsFromCoreData()
        tableView.reloadData()
    }
    

}