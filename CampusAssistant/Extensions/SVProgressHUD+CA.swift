//
//  SVProgressHUD+CA.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/18.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD{
    class func showErrorMessage(message:String){
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showErrorWithStatus(message)
    }
    
    class func showSuccessMessage(message:String){
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccessWithStatus(message)
    }
    
}