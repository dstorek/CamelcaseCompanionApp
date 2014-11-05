//
//  PassViewController.swift
//  CamelcaseCompanionApp2
//
//  Created by Daniel Storek on 02/11/14.
//  Copyright (c) 2014 Daniel Storek. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    
    
    @IBAction func doneButtonPresed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func showMap(sender: AnyObject) {
        // Create an Alert Controller
        let actionSheetController : UIAlertController =  UIAlertController(title:"My Title", message: "Select your Choice", preferredStyle: .ActionSheet);
        
        // Create and add the Cancel Action
        let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel ) { action -> Void in
            actionSheetController.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(cancelAction)
        
        // Create and add the showDirectedMap Action
        let showDirectedMapAction : UIAlertAction = UIAlertAction(title: "Show directed map", style: .Default ) { action -> Void in
            actionSheetController.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(showDirectedMapAction)
        
        // Create and add the showMap Action
        let showMapAction : UIAlertAction = UIAlertAction(title: "Show map", style: .Default ) { action -> Void in
            actionSheetController.dismissViewControllerAnimated(true, completion: nil)
        }
        actionSheetController.addAction(showMapAction)
        
        // Present the Alert Controller
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
    
    @IBOutlet var organizationNameLabel: UILabel!
    @IBOutlet var localizedNameLabel: UILabel!
    @IBOutlet var localizedDescriptionLabel: UILabel!
    @IBOutlet var passImageView: UIImageView!
    @IBOutlet var userInfoLabel: UILabel!
    @IBOutlet var relevantDateLabel: UILabel!
    @IBOutlet var balanceLabel: UILabel!
    @IBOutlet var platnostLabel: UILabel!
    
    var passImage : UIImage?
    var localizedDescription : String?
    var localizedName : String?
    var organizationName : String?
    var relevantDate : String?
    var userInfo : String?
    var balance : String?
    var platnost : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if localizedDescription != nil {
             localizedDescriptionLabel.text = localizedDescription
        }
        
        if localizedName != nil {
            localizedNameLabel.text = localizedName
        }
        
        if organizationName != nil {
            organizationNameLabel.text = organizationName
        }
        
        if passImage != nil {
            passImageView.image = passImage
        }
        if relevantDate != nil {
            relevantDateLabel.text = relevantDate
        }
        if userInfo != nil {
            userInfoLabel.text = userInfo
        }
        if balance != nil {
            balanceLabel.text = balance
        }
        
        if platnost != nil {
            platnostLabel.text = platnost
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
