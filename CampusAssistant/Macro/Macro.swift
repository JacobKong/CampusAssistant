//
//  CAMacro.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/16.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Foundation

/**
*   替代oc中的#define,列举一些常用宏
*/
// 屏幕的物理宽度
let kScreenWidth = UIScreen.mainScreen().bounds.size.width
// 屏幕的物理高度
let kScreenHeight = UIScreen.mainScreen().bounds.size.height
// 屏幕尺寸
let kScreenBounds = UIScreen.mainScreen().bounds

/**
 *   除了一些简单的属性直接用常量表达,更推荐用全局函数来定义替代宏
 */
 // 判断系统版本
func kIS_IOS7() ->Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0 }
func kIS_IOS8() -> Bool { return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0 }

// RGBA的颜色设置
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

// App沙盒路径
func kAppPath() -> String! {
    return NSHomeDirectory()
}

// Documents路径
func kBundleDocumentPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
}

// Caches路径
func KCachesPath() -> String! {
    return NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first! as String
}