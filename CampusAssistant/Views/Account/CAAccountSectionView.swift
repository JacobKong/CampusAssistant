//
//  CAAccountSectionView.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAAccountSectionView: UIView {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAAccountSectionView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }

}
