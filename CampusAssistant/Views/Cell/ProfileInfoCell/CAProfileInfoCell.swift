//
//  CAProfileInfoCell.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/20.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAProfileInfoCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAProfileInfoCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib{
        return UINib(nibName: "CAProfileInfoCell", bundle: nil)
    }
}
