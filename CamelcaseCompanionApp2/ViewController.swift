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
    var myArray = ["220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg","220.jpg", ]
    
    // var myImage : UIImage!
    var myImageView : UIImageView!
    
    @IBAction func shareButtonTapped(sender: AnyObject) {
        
        if PKPassLibrary.isPassLibraryAvailable() == false {
            println("passLibrary is not available on this device")
            return
        }
        
        var passLib = PKPassLibrary()
        self.passArray = passLib.passes()
        println("number of passes is \(passArray.count)")
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
        
        collectionView!.dataSource = self
        collectionView!.delegate = self
        //collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView!.registerClass(PassCell.self, forCellWithReuseIdentifier: "cell")
        
        if PKPassLibrary.isPassLibraryAvailable() == false {
            println("passLibrary is not available on this device")
            return
        }
        
        var passLib = PKPassLibrary()
        self.passArray = passLib.passes()
        
        if passArray.count > 0 {
            var onePass: AnyObject = passArray[0]
            // println("\(onePass.localizedName)")
            //println("\(onePass.organizationName)")
            //myImage = onePass.icon
        }
    }
    
    // Data source methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return passArray.count
        return myArray.count
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
                var myImage = passArray[0].icon
                var myFrame : CGRect
                if myImage != nil {
                    var myImageSize = myImage!.size
                    
                    if myImageSize.width > 120.0 || myImageSize.height > 120.0 {
                        myFrame = CGRectMake(5,5,120,120)
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
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        // DESELECT ITEM
    }
    
    // ViewFlowLayout delegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
        var retval = CGSizeMake(120,120)
        retval.height += 20
        retval.width += 20
        return retval            
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            
         return UIEdgeInsetsMake(40, 10, 40, 0)
    }
    
    /*- (UICollectionReusableView *)collectionView:
    (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
    {
    return [[UICollectionReusableView alloc] init];
    }*/
    
    

}

