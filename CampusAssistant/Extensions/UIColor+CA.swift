//
//  UIColor+CA.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import Foundation

extension UIColor{
    class func caNavigationBarColor() -> UIColor {
        return kRGBA(74, g: 144, b: 226, a: 1.0)
    }
    
    class func caTintColor() -> UIColor {
        return kRGBA(249, g: 138, b: 50, a: 1.0)
    }
    
    class func caLightAlphaTextFieldBgColor() -> UIColor{
        return kRGBA(255, g: 255, b: 255, a: 0.1)
    }
    
    class func caLightAlphaTextFieldPlaceholderTextColor() -> UIColor{
        return kRGBA(255, g: 255, b: 255, a: 0.5)
    }
    
}