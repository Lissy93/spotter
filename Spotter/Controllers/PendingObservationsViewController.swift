
import Foundation
import CoreData
import UIKit

class PendingObservationsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{


    @IBOutlet weak var tableView: UITableView!
    
    var observations = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    
    @IBAction func uploadObservationsPressed(sender: UIButton) {
        
        
    }
    

}