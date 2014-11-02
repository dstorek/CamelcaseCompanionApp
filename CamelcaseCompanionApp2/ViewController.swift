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
    var myArray = ["220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg", ]
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
        if PKPassLibrary.isPassLibraryAvailable() == false {
            println("passLibrary is not available on this device")
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
        var navBarImage = UIImage(named: "navbar.png")!
        let myInsets : UIEdgeInsets = UIEdgeInsetsMake(27, 27, 27, 27)
        navBarImage = navBarImage.resizableImageWithCapInsets(myInsets)
        
        toolbar.setBackgroundImage(navBarImage, forToolbarPosition: .Any , barMetrics: .Default)
        
        //collectionView!.dataSource = self
        //collectionView!.delegate = self
        //collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView!.registerClass(PassCell.self, forCellWithReuseIdentifier: "cell")
        
        /*
        uiCollectionView.registerClass(MyFooterView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        */
        
        if PKPassLibrary.isPassLibraryAvailable() == false {
            println("passLibrary is not available on this device")
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
        cell.backgroundColor = UIColor.whiteColor()
        
        if passArray.count != 0 {
                // var myImage = UIImage(named: myArray[indexPath.row])
                // TODO check that icon.png exists
                var myImage = passArray[indexPath.item].icon
                var myFrame : CGRect
                if myImage != nil {
                    var myImageSize = myImage!.size
                    
                    if myImageSize.width > 160.0 || myImageSize.height > 160.0 {
                        myFrame = CGRectMake(5,5,150,150)
                    } else if myImageSize.width < 60.0 || myImageSize.height < 60.0 {
                        myFrame = CGRectMake(5,5, 2 * myImageSize.width, 2 * myImageSize.height)
                    } else {
                        myFrame = CGRectMake(5,5, myImageSize.width, myImageSize.height)
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
        
        /*
        override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
            if segue.identifier == "push" {
                
            }
        */
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // DESELECT ITEM
    }
    
    // ViewFlowLayout delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
        var retval = CGSizeMake(140,140)
        retval.height += 20
        retval.width += 20
        return retval            
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
         return UIEdgeInsetsMake(15, 15, 15, 15)
    }
    
   func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            
            // var resusableView : UICollectionReusableView
            
            if kind == UICollectionElementKindSectionHeader {
            
                let headerView : PassHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "PassHeaderView", forIndexPath: indexPath) as PassHeaderView
            
                //NSString *searchTerm = self.searches[indexPath.section]; [headerView setSearchText:searchTerm];
                var headerTerm = "moje kupony"
                headerView.headerLabel.text = headerTerm
            
                var myImage = UIImage(named: "header_bg.png")!
                let myInsets : UIEdgeInsets = UIEdgeInsetsMake(68, 68, 68, 68)
                myImage = myImage.resizableImageWithCapInsets(myInsets)
                headerView.backgroundImageView.center = headerView.center;
                headerView.backgroundImageView.image = myImage
             
                return headerView
            
            } else  {
                
                let footerView : PassFooterView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "PassFooterView", forIndexPath: indexPath) as PassFooterView
                
                    var myImage = UIImage(named: "decoration_snail.png")!
                    // let myInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
                    // myImage = myImage.resizableImageWithCapInsets(myInsets)
                    footerView.footerImageView.center = footerView.center;
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

