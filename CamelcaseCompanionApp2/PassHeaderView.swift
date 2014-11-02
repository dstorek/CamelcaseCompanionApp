//
//  PassHeader.swift
//  CamelcaseCompanionApp2
//
//  Created by Daniel Storek on 02/11/14.
//  Copyright (c) 2014 Daniel Storek. All rights reserved.
//

import UIKit

class PassHeaderView : UICollectionReusableView {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}