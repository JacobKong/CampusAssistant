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
    
    class func RBSquareImage(image: UIImage) -> UIImage {
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        
        let cropSquare = CGRectMake(0, (originalHeight - originalWidth)/2, originalWidth, originalWidth)
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        
        return UIImage(CGImage: imageRef!, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)
    }
    
    class func imageByCroppingImage(image : UIImage, size : CGSize) -> UIImage{
        let refWidth : CGFloat = CGFloat(CGImageGetWidth(image.CGImage))
        let refHeight : CGFloat = CGFloat(CGImageGetHeight(image.CGImage))
        
        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2
        
        let cropRect = CGRectMake(x, y, size.height, size.width)
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, cropRect)
        
        let cropped : UIImage = UIImage(CGImage: imageRef!, scale: 0, orientation: image.imageOrientation)
        
        
        return cropped
    }

    
}