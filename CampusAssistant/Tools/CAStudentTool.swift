//
//  CAStudentTool.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/20.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAStudentTool: NSObject {
    static let CAStudentFile = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0].stringByAppendingPathComponent("student.data")
    
    class func isExistStudentData() -> Bool{
        let fileMgr = NSFileManager.defaultManager()
        let exist:Bool = fileMgr.fileExistsAtPath(CAStudentFile)
        return exist
    }
    
    class func student() -> CAStudent{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(CAStudentFile) as! CAStudent
    }
    
    class func saveStudent(student:CAStudent){
        NSKeyedArchiver.archiveRootObject(student, toFile: CAStudentFile)
    }
    
    class func removeStudent(){
        let fileMgr = NSFileManager.defaultManager()
        do {
            try fileMgr.removeItemAtPath(CAStudentFile)
        }catch let MyFileError{
            print(MyFileError)
        }
    }
}
