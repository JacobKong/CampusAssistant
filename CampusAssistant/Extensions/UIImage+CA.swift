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
    
    class func resizeableImageWithName(name: String) -> UIImage{
        let normal = UIImage(named: name)
        
        let w:CGFloat = normal!.size.width * 0.5
        let h:CGFloat = normal!.size.height * 0.5
        return (normal?.resizableImageWithCapInsets(UIEdgeInsetsMake(h, w, h, w)))!
        
    }
    
}