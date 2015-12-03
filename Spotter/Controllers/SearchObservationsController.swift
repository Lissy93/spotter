
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
        }
        else if (segue.identifier! == "dateTimeObs") {
            destinationVC.urlExt = "/observations/datetime/"+txtObsDateTime.text!
        }
        else if (segue.identifier! == "categoryObs") {
            destinationVC.urlExt = "/observations/category/"+txtObsCategory.text!
        }
        else{
            destinationVC.urlExt = "/observations"
        }
        
    }

}