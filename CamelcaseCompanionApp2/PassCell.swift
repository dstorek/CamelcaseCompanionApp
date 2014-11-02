//
//  PassCell.swift
//  CamelcaseCompanionApp2
//
//  Created by Daniel Storek on 01/11/14.
//  Copyright (c) 2014 Daniel Storek. All rights reserved.
//

import UIKit

class PassCell : UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
