//
//  CADeanAccountTool.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/18.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CADeanAccountTool: NSObject {
    static let CADeanAccountFile = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0].stringByAppendingPathComponent("deanAccount.data")
    class func isExistAccountData() -> Bool{
        let fileMgr = NSFileManager.defaultManager()
        let exist:Bool = fileMgr.fileExistsAtPath(CADeanAccountFile)
        return exist
    }
    class func deanAccount() -> CADeanAccount{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(CADeanAccountFile) as! CADeanAccount
    }
    
    class func saveAccount(account:CADeanAccount){
        NSKeyedArchiver.archiveRootObject(account, toFile: CADeanAccountFile)
    }
    
    class func removeAccount(){
        let fileMgr = NSFileManager.defaultManager()
        do {
            try fileMgr.removeItemAtPath(CADeanAccountFile)
        }catch let MyFileError{
            print(MyFileError)
        }
    }

}
