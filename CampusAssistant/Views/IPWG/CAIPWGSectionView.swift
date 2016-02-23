//
//  CAIPWGSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAIPWGSectionView: UIView {
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAIPWGSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
}
