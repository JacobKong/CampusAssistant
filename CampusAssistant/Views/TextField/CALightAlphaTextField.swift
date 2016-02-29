//
//  CADarkAlphaTextField.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/23.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CALightAlphaTextField: UITextField {
    var leftImage:String = ""
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.backgroundColor = UIColor.caLightAlphaTextFieldBgColor()
        self.borderStyle = UITextBorderStyle.None
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
//        let placeholderAttrStr = NSAttributedString(string: <#T##String#>, attributes: <#T##[String : AnyObject]?#>))
//        self.placeholder
    }
    
    override func didMoveToWindow() {
        self.leftViewMode = UITextFieldViewMode.Always
        let leftImageView = UIImageView.init(image: UIImage(named: leftImage))
        leftImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.leftView = leftImageView
        self.bounds = CGRectMake(0, 0, kScreenWidth-90, 50)
    }
    
    override func leftViewRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(15, bounds.height*0.5 - 10, 20, 20)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectMake(55, 0, bounds.width*0.6, bounds.height)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return textRectForBounds(bounds)
    }
    
    override func drawPlaceholderInRect(rect: CGRect) {
        if self.placeholder != nil{
            let placeholderColor = UIColor.caLightAlphaTextFieldPlaceholderTextColor()
            let font = UIFont(name: "Montserrat-Regular", size: 16)!
            let textFontAttributes = [
                NSFontAttributeName:font,
                NSForegroundColorAttributeName:placeholderColor
            ]
            self.placeholder!.drawInRect(CGRectMake(0, rect.size.height*0.5 - 9, rect.size.width, rect.size.height), withAttributes: textFontAttributes)
        }
    }
    
//    override func drawTextInRect(rect: CGRect) {
//        if self.text != nil{
//            let textColor = UIColor.whiteColor()
//            let font = UIFont(name: "Montserrat-Regular", size: 16)!
//            let textFontAttributes = [
//                NSFontAttributeName:font,
//                NSForegroundColorAttributeName:textColor
//            ]
//            self.text!.drawInRect(CGRectMake(0, rect.size.height*0.5 - 9, rect.size.width, rect.size.height), withAttributes: textFontAttributes)
//        }
//    }
}
