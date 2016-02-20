//
//  NSData+CA.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/20.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import Foundation

extension NSData{
    // Convert from NSData to json object
    class func NSDataToJSON(data: NSData) -> AnyObject? {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }

    // Convert from JSON to nsdata
    class func JSONToNSData(json: AnyObject) -> NSData?{
        do {
            return try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
}