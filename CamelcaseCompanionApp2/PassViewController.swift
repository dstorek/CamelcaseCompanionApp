//
//  PassViewController.swift
//  CamelcaseCompanionApp2
//
//  Created by Daniel Storek on 02/11/14.
//  Copyright (c) 2014 Daniel Storek. All rights reserved.
//

import UIKit
import MapKit

class PassViewController: UIViewController {
    
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
    
    // MKPlacemrak properties
    var name : String?
    var phone : String?
    var website : String?
    var gps : String?
    var gpsCoordinates : CLLocationCoordinate2D?
    
    @IBAction func doneButtonPresed(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func showMap(sender: AnyObject) {
        //TODO check that the pass contains valid GPS coordinates (latitude, longitude) and these coordinates are valid
        if gps != nil {
            gpsCoordinates = nil
            let gpsArray = gps!.componentsSeparatedByString(", ")
            let latitudeString: NSString = gpsArray[0]
            let longitudeString: NSString = gpsArray[1]
            gpsCoordinates = CLLocationCoordinate2DMake(latitudeString.doubleValue, longitudeString.doubleValue)
        }
        
        if gpsCoordinates != nil {
            
            var placemark : MKPlacemark = MKPlacemark(coordinate: self.gpsCoordinates!, addressDictionary: nil)
            var item : MKMapItem = MKMapItem(placemark: placemark)
            
            if self.name != nil {
                item.name = self.name!
            } else {
                item.name = "X marks the spot!"
            }
            
            if self.phone != nil {
                item.phoneNumber = self.phone!
            }
            
            if self.website != nil {
                item.url = NSURL(string: self.website!)
            }
      
            // Create an Alert Controller
            let actionSheetController : UIAlertController =  UIAlertController(title:"My Title", message: "Select your Choice", preferredStyle: .ActionSheet);
            
            // Create and add the Cancel Action
            let cancelAction : UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel ) { action -> Void in
                actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(cancelAction)
            
            // Create and add the showDirectedMapWalking Action
            let showDirectedMapWalkingAction : UIAlertAction = UIAlertAction(title: "Show me to walk there", style: .Default ) { action -> Void in
                
                let directionsModeKey: String = "MKLaunchOptionsDirectionsModeWalking"
                var dictionary = [
                    MKLaunchOptionsDirectionsModeKey : directionsModeKey,
                    MKLaunchOptionsShowsTrafficKey: "YES"
                ]
                item.openInMapsWithLaunchOptions(dictionary)
                
                // actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(showDirectedMapWalkingAction)
            
            // Create and add the showDirectedMapDriving Action
            let showDirectedMapDrivingAction : UIAlertAction = UIAlertAction(title: "Show me to drive there", style: .Default ) { action -> Void in
             
                let directionsModeKey: String = "MKLaunchOptionsDirectionsModeDriving" // "MKLaunchOptionsDirectionsModeWalking"
                var dictionary = [
                    MKLaunchOptionsDirectionsModeKey : directionsModeKey,
                    MKLaunchOptionsShowsTrafficKey: "YES"
                ]
                item.openInMapsWithLaunchOptions(dictionary)
                
                // actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(showDirectedMapDrivingAction)
            
            // Create and add the showMap Action
            let showMapAction : UIAlertAction = UIAlertAction(title: "Show on map", style: .Default ) { action -> Void in
                
                var dictionary = [
                    MKLaunchOptionsMapTypeKey : 2 // (Standard map), 1 (satellite map), 2 (Hybrid map)
                ]
                
                item.openInMapsWithLaunchOptions(dictionary)
                
                // actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(showMapAction)
            
            // Present the Alert Controller
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
        } else {
        
            let actionSheetController : UIAlertController =  UIAlertController(title:"Alert", message: "Lokace tohoto passu neni k dispozici", preferredStyle: .Alert);
            
            // Create and add the OK Action
            let okAction : UIAlertAction = UIAlertAction(title: "OK", style: .Default ) { action -> Void in
                actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(okAction)
            
            // Present the Alert Controller
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        }
    }

    
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
