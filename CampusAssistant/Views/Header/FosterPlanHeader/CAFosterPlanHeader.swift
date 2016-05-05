//
//  CAFosterPlanHeader.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/5.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAFosterPlanHeader: UIView {

    @IBOutlet weak var kindLabel: UILabel!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAFosterPlanHeader", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "CAFosterPlanHeader", bundle: nil)
    }

}
