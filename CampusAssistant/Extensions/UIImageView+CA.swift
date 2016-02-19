//
//  UIImageView+CA.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/19.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import Foundation

extension UIImageView{
    class func clipImageViewToCircle(imageView:UIImageView, borderWidth: CGFloat, borderColor:UIColor) -> UIImageView{
        imageView.layer.borderWidth = borderWidth
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = borderColor.CGColor
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        return imageView
    }
}