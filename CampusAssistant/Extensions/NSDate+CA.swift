//
//  NSDate+CA.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/5/19.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import Foundation

extension NSDate {
    
    
    func dayOfWeek() -> Int {
        
        
        let interval = self.timeIntervalSince1970;
        
        
        let days = Int(interval / 86400);
        
        
        return (days - 3) % 7;
        
        
    }
    
    
}