//
//  CAProfileHeader.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/19.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAProfileHeader: UIView {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var englishNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAProfileHeader", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView = UIImageView.clipImageViewToCircle(iconImageView, borderWidth: 0, borderColor: UIColor.whiteColor())
    }
}
