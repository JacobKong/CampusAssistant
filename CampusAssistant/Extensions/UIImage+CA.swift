//
//  UIImage+CA.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/19.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import Foundation

extension UIImage{
    class func clipImageWithName(name: String, borderWidth: CGFloat, borderColor:UIColor) -> UIImage{
        let oldImage = UIImage(named: name)
        return oldImage!
    }
    
}