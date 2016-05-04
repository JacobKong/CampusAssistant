//
//  CAEmptyRoomHeader.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/3.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAEmptyRoomHeader: UICollectionViewCell {

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CAEmptyRoomHeader", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    class func nib() -> UINib {
        return UINib(nibName: "CAEmptyRoomHeader", bundle: nil)
    }

}
