//
//  ViewController.swift
//  CamelcaseCompanionApp2
//
//  Created by Daniel Storek on 01/11/14.
//  Copyright (c) 2014 Daniel Storek. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var passArray = []
    var currentPass : PKPass?
    var myImageView : UIImageView!
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
        if PKPassLibrary.isPassLibraryAvailable() == false {
            // println("passLibrary is not available on this device")
            // Create actionSheet
            let actionSheetController : UIAlertController =  UIAlertController(title:"Alert", message: "PassLibrary is not available on this device", preferredStyle: .Alert);
            
            // Create and add the OK Action
            let okAction : UIAlertAction = UIAlertAction(title: "OK", style: .Default ) { action -> Void in
                actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(okAction)
            
            // Present the Alert Controller
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
            // Return
            return
        }
        
        var passLib = PKPassLibrary()
        self.passArray = passLib.passes()
        // println("number of passes is \(passArray.count)")
        self.collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myView.backgroundColor = UIColor(patternImage: UIImage(named: "bg_cork.png")!)
        // THIS sets the toolbar background image in the main ViewController
        // var navBarImage = UIImage(named: "navbar.png")!
        // let myInsets : UIEdgeInsets = UIEdgeInsetsMake(27, 27, 27, 27)
        // navBarImage = navBarImage.resizableImageWithCapInsets(myInsets)
        // toolbar.setBackgroundImage(navBarImage, forToolbarPosition: .Any , barMetrics: .Default)
        
        //collectionView!.dataSource = self
        //collectionView!.delegate = self
        //collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView!.registerClass(PassCell.self, forCellWithReuseIdentifier: "cell")
        
        /*
        uiCollectionView.registerClass(MyFooterView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        */
        
        if PKPassLibrary.isPassLibraryAvailable() == false {
            // println("passLibrary is not available on this device")
            // inform user that his device do not support passes
            // Create an Alert Controller
            let actionSheetController : UIAlertController =  UIAlertController(title:"Alert", message: "PassLibrary is not available on this device", preferredStyle: .Alert);
            
            // Create and add the OK Action
            let okAction : UIAlertAction = UIAlertAction(title: "OK", style: .Default ) { action -> Void in
                actionSheetController.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheetController.addAction(okAction)
           
            // Present the Alert Controller
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
            // Return
            return
        }
        
        var passLib = PKPassLibrary()
        self.passArray = passLib.passes()
        
    }
    
    // Data source methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passArray.count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
//        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        var cell: PassCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as PassCell
        // cell.backgroundColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.whiteColor()

        
        if passArray.count != 0 {
                // var myImage = UIImage(named: myArray[indexPath.row])
                // TODO check that icon.png exists
                var myImage = passArray[indexPath.item].icon
                var myFrame : CGRect
                if myImage != nil {
                    var myImageSize = myImage!.size
                    
                    if myImageSize.width > 58 || myImageSize.height > 58 {
                        // myFrame = CGRectMake(5,5,130,130)
                        myFrame = CGRectMake(10,10,58,58)
                    } else {
                       // myFrame = CGRectMake(5,5, myImageSize.width, myImageSize.height)
                        myFrame = CGRectMake(10,10, myImageSize.width, myImageSize.height)
                    }
                
                myImageView = UIImageView(frame: myFrame)
                myImageView.image = myImage
                cell.contentView.addSubview(myImageView)
                    
            }
        }
        return cell
    }
    
    // Delegate methods
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // SELECT item
        
        currentPass = passArray[indexPath.item] as? PKPass
        self.performSegueWithIdentifier("ShowPass", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // DESELECT ITEM
    }
    
    // ViewFlowLayout delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var retval : CGSize = passArray[indexPath.item].icon!.size.width > 0 ? passArray[indexPath.item].icon!.size : CGSizeMake(58,58)
        retval.height += 20
        retval.width += 20
        return retval            
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
         return UIEdgeInsetsMake(50, 10, 50, 10) // (header to first row margin, left side margin, last row to footer margin, right side margin)
    }
    
   func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
            // var resusableView : UICollectionReusableView
            
            if kind == UICollectionElementKindSectionHeader {
            
                let headerView : PassHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "PassHeaderView", forIndexPath: indexPath) as PassHeaderView
            
                //NSString *searchTerm = self.searches[indexPath.section]; [headerView setSearchText:searchTerm];
                var headerString = "moje kupony"
                headerView.headerLabel.text = headerString
            
                var myImage = UIImage(named: "header_bg.png")!
                // println(myImage.size)
                let myInsets : UIEdgeInsets = UIEdgeInsetsMake(68, 68, 68, 68)
                myImage = myImage.resizableImageWithCapInsets(myInsets)
                // println(myImage.size)
                // println("headerbackgroundimageview.center \(headerView.backgroundImageView.center)")
                // println("headerview.center \(headerView.center)")
                // headerView.backgroundImageView.center = headerView.center;
                // println(headerView.backgroundImageView.frame)
                headerView.backgroundImageView.image = myImage
                // println(headerView.backgroundImageView.frame)
                // println(headerView.backgroundImageView.image!.size)
                headerView.backgroundImageView.center = headerView.center
             
                return headerView
            
            } else  {
                
                let footerView : PassFooterView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "PassFooterView", forIndexPath: indexPath) as PassFooterView
                
                    var myImage = UIImage(named: "decoration_snail.png")!
                    // let myInsets : UIEdgeInsets = UIEdgeInsetsMake(68, 68, 68, 68)
                    // myImage = myImage.resizableImageWithCapInsets(myInsets)
                    // println("footerimageview.center \(footerView.footerImageView.center)")
                    // println("footerView.center \(footerView.center)")
                    // footerView.footerImageView.center = footerView.center;
                    footerView.footerImageView.image = myImage

                    return footerView
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowPass" {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var passViewController: PassViewController = segue.destinationViewController as PassViewController
        // var cell = collectionView.cellForItemAtIndexPath(0)
            
            if currentPass != nil {
                passViewController.localizedDescription = currentPass?.localizedDescription
                passViewController.localizedName = currentPass?.localizedName
                passViewController.organizationName = currentPass?.organizationName
                passViewController.passImage = currentPass?.icon
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a" // superset of OP's format
                let relevantDateString = dateFormatter.stringFromDate(NSDate())
                passViewController.relevantDate = relevantDateString
                
                passViewController.platnost = currentPass?.localizedValueForFieldKey("subtitle") as? String // gym pass do kdy plati
                passViewController.name = currentPass?.localizedValueForFieldKey("name") as? String
                passViewController.phone = currentPass?.localizedValueForFieldKey("phone") as? String
                passViewController.website = currentPass?.localizedValueForFieldKey("website") as? String
                passViewController.gps = currentPass?.localizedValueForFieldKey("gps") as? String
                
                
      
                var balanceInt = currentPass?.localizedValueForFieldKey("balance") as? Int
                if balanceInt != nil {
                    var balanceString = String(balanceInt!)
                    passViewController.balance = balanceString
                    // passViewController.balance = currentPass?.localizedValueForFieldKey("balance") as? String // loyalty pass
                }
                
                // passViewController.userInfo = currentPass?.userInfo // JSON data napr. favorite drink
                // passViewController.balance = currentPass?.localizedValueForFieldKey("serialNumber")
                // println(currentPass?.localizedValueForFieldKey("balance")) // loyalty
                // println(currentPass?.localizedValueForFieldKey("deal!")) // loyalty nefunguje
                // println(currentPass?.localizedValueForFieldKey("subtitle")) // gym
                // println(currentPass?.localizedValueForFieldKey("member")) // gym
            }
            
        }

    }

}

