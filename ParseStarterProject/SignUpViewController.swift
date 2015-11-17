//
//  SignUpViewController.swift
//  ParseStarterProject
//
//  Created by William Peregoy on 2015/10/18.
//  Copyright © 2015年 Parse. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWomen"] = interestedInWomen.on
        PFUser.currentUser()?.save()
        
        self.performSegueWithIdentifier("signup", sender: self)

        
    }
    
    @IBOutlet weak var interestedInWomen: UISwitch!
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender, email"])
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                print(error)
                
            } else {
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                PFUser.currentUser()?["email"] = result["email"]
                
                PFUser.currentUser()?.save()
                
                let userId = result["id"] as? String
                
                let facebookProfilePictureUrl = "https://graph.facebook.com/" + userId! + "/picture?type=large"
                
                if let fbpicUrl = NSURL(string: facebookProfilePictureUrl) {
                    
                    if let data = NSData(contentsOfURL: fbpicUrl) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile:PFFile = PFFile(data: data)
                        PFUser.currentUser()?["image"] = imageFile
                        PFUser.currentUser()?.save()
                        
                        
                    }
                    
                }
            }
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
   /* override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "signin") {
            let destination = segue.destinationViewController
        }
        
    } */


}
