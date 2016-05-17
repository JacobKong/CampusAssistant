//
//  CACreditCell.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/5.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CACreditCell: UITableViewCell {
    
    @IBOutlet weak var courseGroupLabel: UILabel!
    
    @IBOutlet weak var information1Label: UILabel!
    
    @IBOutlet weak var information2Label: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CACreditCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib{
        return UINib(nibName: "CACreditCell", bundle: nil)
    }
}
