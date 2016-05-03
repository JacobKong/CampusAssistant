//
//  CACollectionTitle.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/18.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CACollectionTitleHeader: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CACollectionTitleHeader", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "CACollectionTitleHeader", bundle: nil)
    }
}
