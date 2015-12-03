
import Foundation
import UIKit

class SearchObservationsController : UIViewController{

    // UITextFields
    @IBOutlet weak var txtObsUsername: UITextField!
    @IBOutlet weak var txtObsDateTime: UITextField!
    @IBOutlet weak var txtObsCategory: UITextField!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC:ViewObservationsViewController = segue.destinationViewController as! ViewObservationsViewController
        
        if (segue.identifier! == "userObs") {
            destinationVC.urlExt = "/observations/user/"+txtObsUsername.text!
            destinationVC.viewTitle = "Observations by User"
        }
        else if (segue.identifier! == "dateTimeObs") {
            destinationVC.urlExt = "/observations/datetime/"+txtObsDateTime.text!
            destinationVC.viewTitle = "Observations by Date"
        }
        else if (segue.identifier! == "categoryObs") {
            destinationVC.urlExt = "/observations/category/"+txtObsCategory.text!
            destinationVC.viewTitle = "Observations by Category"
        }
        else{
            destinationVC.urlExt = "/observations"
            destinationVC.viewTitle = "All Observations"
        }
        
    }

}