//
//  CAFunctionButton.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/17.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAFunctionCell: UICollectionViewCell {

    @IBOutlet weak var functionIcon: UIImageView!
    @IBOutlet weak var functionLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAFunctionCell", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonClicked(sender: AnyObject) {
//        var target_vc = NSClassFromString(target_vc_name)
    }
}
