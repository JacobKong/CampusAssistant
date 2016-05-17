//
//  CAFosterPlanCell.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/5.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAFosterPlanCell: UITableViewCell {

    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAFosterPlanCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib{
        return UINib(nibName: "CAFosterPlanCell", bundle: nil)
    }
}
