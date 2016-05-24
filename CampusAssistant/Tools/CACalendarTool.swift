//
//  CACalendarTool.swift
//  CampusAssistant
//
//  Created by Encode.X on 16/5/18.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CACalendarTool: NSObject {
    // 2016-03-06 00:00
    let ekEventStore = EKEventStore()
    var identifierArray:[String]
    var calendarIdentifierArray:[String]
    var events:[EKEvent]
    var courseIdentifier:NSArray?
    var calendarIdentifier:NSArray?
    var formatter:NSDateFormatter = NSDateFormatter()
    var termStartDate:NSDate
    
    typealias eventHandler = (event:EKEvent?) -> Void
    
    override init() {
        self.formatter.dateFormat = "yyyy-MM-dd HH:mm"
        self.formatter.locale = NSLocale(localeIdentifier:"zh_CN")
        self.identifierArray = Array()
        self.calendarIdentifierArray = Array()
        self.events = Array()
        termStartDate = formatter.dateFromString("2016-03-06 00:00")!
    }
    
    class func refreshCalendarWithCourseList(courseList:[[String]]){
//        print(_instance.events)
//        print(_instance.identifierArray)
        _instance.removeAllEvents(courseList)
//        print(courseList)
    }
    
    class func getTodayNextEvent(handler:eventHandler){
        _instance.ekEventStore.requestAccessToEntityType(EKEntityType.Event) { (granted, error) in
            
            _instance.calendarIdentifier = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/calendar.plist")
            if (_instance.calendarIdentifier == nil){
                _instance.addNewCalendar()
                _instance.calendarIdentifier = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/calendar.plist")
            }
            
            let identifier = _instance.calendarIdentifier![0] as! String
            let calendar = _instance.ekEventStore.calendarWithIdentifier(identifier)
            
            let t_from = NSDate()
            let formatter = NSDateFormatter();
            formatter.dateFormat = "yyyy-MM-dd";
            formatter.locale = NSLocale(localeIdentifier:"zh_CN")
            let today = formatter.dateFromString(formatter.stringFromDate(t_from))!
            
            let t_to = today.dateByAddingTimeInterval(NSTimeInterval(24*3600))
            
            let predicate = _instance.ekEventStore.predicateForEventsWithStartDate(
                t_from,
                endDate: t_to,
                calendars: [calendar!])
            
            let events = _instance.ekEventStore.eventsMatchingPredicate(predicate)
            
            if events.count > 0{
                handler(event: events[0])
            }else{
                handler(event: nil)
            }
        }
    }
    
    private func refreshCalendar(courseList:[[String]], calendarToRefresh:EKCalendar){
        var day_counter = 0, time_counter:Double = 0
        
        self.identifierArray.removeAll()
        self.events.removeAll()
        
        for _item in courseList {
            if _item.count != 0 {
                for i in 0 ..< _item.count / 4 {
                    let weeks = CARegexTool.parseCourseWeekDescription(_item[i*4+3])
                    for week in weeks{
                        let t_start_week = Int(week[0])
                        let interval_days = (t_start_week! - 1) * 7 + day_counter + 1
                        var interval_seconds = (Double(8 + interval_days * 24) + time_counter) * 3600
                        let t_from:NSDate = self.termStartDate.dateByAddingTimeInterval(NSTimeInterval(interval_seconds))
                        interval_seconds += 7200
                        let t_to:NSDate = self.termStartDate.dateByAddingTimeInterval(NSTimeInterval(interval_seconds))
                        
                        if week.count == 1{
                            self.prepareEvent(_item[i*4], location: _item[i*4+2], notes: _item[i*4+1], fromTime: t_from, toTime: t_to, isRecurrenceEvent: false, endDate: nil, calendar: calendarToRefresh)
                        }else{
                            let t_end_week = Int(week[1])
                            interval_seconds += Double((t_end_week! - t_start_week!) * 7 * 24 * 3600)
                            let t_end:NSDate = self.termStartDate.dateByAddingTimeInterval(NSTimeInterval(interval_seconds))
                            self.prepareEvent(_item[i*4], location: _item[i*4+2], notes: _item[i*4+1], fromTime: t_from, toTime: t_to, isRecurrenceEvent: true, endDate: t_end, calendar: calendarToRefresh)
                        }
                    }
                }
            }
            day_counter += 1
            if day_counter == 7{
                day_counter = 0
                time_counter += 2
                if time_counter == 4{
                    time_counter += 2
                }else if time_counter == 10{
                    time_counter += 0.5
                }
                if time_counter == 14.5 {
                    time_counter = 0
                }
            }
            // test code
            //            break
        }
        
        self.addAllEventsToCalendar()
    }
    
    private func prepareEvent(title:String, location:String, notes:String, fromTime:NSDate, toTime:NSDate, isRecurrenceEvent:Bool, endDate:NSDate?, calendar:EKCalendar){
//        print(formatter.stringFromDate(fromTime))
//        print(formatter.stringFromDate(toTime))
//        if(isRecurrenceEvent){
//            print(formatter.stringFromDate(endDate!))
//        }
        
        let event:EKEvent = EKEvent(eventStore: self.ekEventStore)
        event.title = title
        event.startDate = fromTime
        event.endDate = toTime
        event.location = location
        event.notes = notes
        event.calendar = calendar
        
        if(isRecurrenceEvent){
            let recurrence_rule = EKRecurrenceRule(recurrenceWithFrequency: EKRecurrenceFrequency.Weekly, interval: 1, end: EKRecurrenceEnd(endDate: endDate!))
            event.addRecurrenceRule(recurrence_rule)
        }
        
        _instance.events.append(event)
//        print("PREPARED EVENT")
    }
    
    private func addAllEventsToCalendar(){
        self.ekEventStore.requestAccessToEntityType(EKEntityType.Event) { (granted, error) in
            if granted && error == nil{
                do{
                    for event in self.events{
                        try self.ekEventStore.saveEvent(event, span: EKSpan.ThisEvent)
                        _instance.identifierArray.append(event.eventIdentifier)
                    }
                    try self.ekEventStore.commit()
                    print("SAVED EVENTS")
                    self.saveAllEventIdentifiers()
                }catch{
                    print("CALENDAR INSERT ERROR!!!")
                }
            }
        }
    }
    
    private func removeAllEvents(courseListToRefresh:[[String]]){
//        self.courseIdentifier = NSArray()
//        let filePath:String = NSHomeDirectory() + "/Documents/courseid.plist"
//        self.courseIdentifier?.writeToFile(filePath, atomically: true)
        
        ekEventStore.requestAccessToEntityType(EKEntityType.Event, completion: { (granted, error) in
            if granted && error == nil {
                _instance.calendarIdentifier = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/calendar.plist")
                if (_instance.calendarIdentifier == nil){
                    _instance.addNewCalendar()
                    _instance.calendarIdentifier = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/calendar.plist")
                }
                
                print(_instance.calendarIdentifier)
                
                let identifier = _instance.calendarIdentifier![0] as! String
                let calendar = _instance.ekEventStore.calendarWithIdentifier(identifier)
                
                self.courseIdentifier = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/courseid.plist")
                if self.courseIdentifier != nil && self.courseIdentifier?.count != 0 {
                    do{
                        for id in self.courseIdentifier! {
                            let eventToRemove = self.ekEventStore.eventWithIdentifier(id as! String)
                            try self.ekEventStore.removeEvent(eventToRemove!, span: EKSpan.FutureEvents)
                        }
                        try self.ekEventStore.commit()
                        print("EVENT DELETED")
                    }catch{
                        print("CALENDAR DELETE ERROR!!!")
                    }
                    self.courseIdentifier = NSArray()
                    let filePath:String = NSHomeDirectory() + "/Documents/courseid.plist"
                    //                    print(filePath)
                    self.courseIdentifier?.writeToFile(filePath, atomically: true)
                    
                    self.refreshCalendar(courseListToRefresh, calendarToRefresh: calendar!)
                }else{
                    self.refreshCalendar(courseListToRefresh, calendarToRefresh: calendar!)
                }
            }
        })
    }
    
    private func saveAllEventIdentifiers(){
        self.courseIdentifier = NSArray(array: self.identifierArray)
        let filePath:String = NSHomeDirectory() + "/Documents/courseid.plist"
        self.courseIdentifier?.writeToFile(filePath, atomically: true)
//        print("IDENTIFIERS SAVED")
    }
    
    private func addNewCalendar(){
        let calendar = EKCalendar(forEntityType: EKEntityType.Event, eventStore: self.ekEventStore)
        calendar.title = "课程表 - 东大校园助手"
        let sourcesInEventStore = _instance.ekEventStore.sources
        calendar.source = sourcesInEventStore.filter({ (source) -> Bool in
            source.sourceType.rawValue == EKSourceType.Local.rawValue
        }).first!
        
        do{
            try self.ekEventStore.saveCalendar(calendar, commit: true)
            
            let identifier = calendar.calendarIdentifier
            let filePath:String = NSHomeDirectory() + "/Documents/calendar.plist"
            self.calendarIdentifierArray.removeAll()
            self.calendarIdentifierArray.append(identifier)
            
            self.calendarIdentifier = NSArray(array:self.calendarIdentifierArray)
            self.calendarIdentifier?.writeToFile(filePath, atomically: true)
            
            print("ADD CALENDAR SUCCESS & SAVED")
        }catch{
            print("ADD CALENDAR FAILED")
        }
    }
}

private let _instance = CACalendarTool()