//
//  CAClassListViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire
//@objc protocol CalendarViewControllerNavigation{
//    func moveToDate(date:NSDate, animated:Bool)
//    func moveToNextPageAnimated(animated:Bool)
//    func moveToPreviousPageAnimated(animated:Bool)
//}
//
//@objc protocol CalendarViewControllerDelegate{
//    func calendarViewController(controller:CAClassListViewController, didShowDate:NSDate)
//    func calendarViewController(controller:CAClassListViewController, didSelectEvent:EKEvent)
//}

class CAClassListViewController: MGCDayPlannerEKViewController {

    let dateFormatter = NSDateFormatter()
    let currentDateLabel =  UILabel()
    let ekEventStore = EKEventStore()
    var courseIdentifier:NSArray?
//    let currentDateButton = UIButton.init(type: UIButtonType.Custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
        setupDayPlannerView()
        
        trySetupCalendarData()
//        self.calendar = NSCalendar.currentCalendar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupNavigationBar(){
        self.title = "看课表"
//        let rightBarBtn = currentDateButton
//        rightBarBtn.setImage(UIImage(named: "navigationbar_side_menu"), forState: .Normal)
//        rightBarBtn.frame = CGRectMake(0, 0, 22, 22)

        self.dateFormatter.dateFormat = "yyyy.M"
        let currentMonth = dateFormatter.stringFromDate(NSDate())
        currentDateLabel.text = currentMonth
        currentDateLabel.textColor = UIColor.whiteColor()
        currentDateLabel.font = UIFont.systemFontOfSize(15)
        currentDateLabel.sizeToFit()
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = currentDateLabel
        self.navigationItem.rightBarButtonItem = rightBarButton

    }
    private func setupDayPlannerView(){
        self.dateFormatter.calendar = self.calendar
        self.dateFormatter.locale = NSLocale.init(localeIdentifier: "zh-CN")
        self.dayPlannerView.backgroundColor = UIColor.whiteColor()
        self.dayPlannerView.backgroundView = UIView()
        self.dayPlannerView.backgroundView.backgroundColor = UIColor.whiteColor()
        self.dayPlannerView.numberOfVisibleDays = 5
        self.dayPlannerView.timeColumnWidth = 50
        self.dayPlannerView.eventIndicatorDotColor = UIColor.caTintColor()
        self.dayPlannerView.hourRange = NSRange.init(location: 7, length: 17)
        self.dayPlannerView.dateFormat = "d eee"
        
    }
    
    private func trySetupCalendarData(){
//        courseIdentifier = NSArray(contentsOfFile: NSHomeDirectory() + "/Documents/courseid.plist")
//        
//        if courseIdentifier != nil && courseIdentifier?.count != 0 {
//            print(courseIdentifier)
//            ekEventStore.requestAccessToEntityType(EKEntityType.Event, completion: { (granted, error) in
//                if granted && error == nil {
//                    for id in self.courseIdentifier! {
//                        let eventToRemove = self.ekEventStore.eventWithIdentifier(id as! String)
//                        do{
//                            try self.ekEventStore.removeEvent(eventToRemove!, span: EKSpan.ThisEvent, commit: true)
//                            print("EVENT DELETED")
//                            
//                            self.courseIdentifier = NSArray()
//                            let filePath:String = NSHomeDirectory() + "/Documents/courseid.plist"
//                            self.courseIdentifier?.writeToFile(filePath, atomically: true)
//                        }catch{
//                            print("CALENDAR DELETE ERROR!!!")
//                        }
//                    }
//                }
//            })
//        }
//        
//        ekEventStore.requestAccessToEntityType(EKEntityType.Event) { (granted, error) in
//            if granted && error == nil{
//                var array:[String] = Array()
//                let event = EKEvent(eventStore: self.ekEventStore)
//                event.title = "测试"
//                event.startDate = NSDate()
//                event.endDate = NSDate()
//                event.location = "信息B221"
//                event.notes = "教师名"
//                event.calendar = self.ekEventStore.defaultCalendarForNewEvents
//                
//                do{
//                    try self.ekEventStore.saveEvent(event, span: EKSpan.ThisEvent)
//                    array.append(event.eventIdentifier)
//                    print("SAVED EVENT")
//                    
//                    self.courseIdentifier = NSArray(array: array)
//                    let filePath:String = NSHomeDirectory() + "/Documents/courseid.plist"
//                    self.courseIdentifier?.writeToFile(filePath, atomically: true)
//                }catch{
//                    print("CALENDAR INSERT ERROR!!!")
//                }
//            }
//        }
        
//        CANetworkTool.setAAOCookies("X82067xK1syLDBSJ4MrV2IuQxS125KlY53wamfL4NKruPYklCtNt!1269920556")
        Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYSTUDENTSCHEDULEBYSELF.APPPROCESS").validate().responseString {
            (response) in
            switch response.result {
            case .Success:
                let r_result: [[String]] = CARegexTool.parseCourseTable(response.result.value!)
                CACalendarTool.refreshCalendarWithCourseList(r_result)
            case .Failure(let error):
                print(error)
            }
            
        }
    }
    
    override func dayPlannerView(view: MGCDayPlannerView!, willDisplayDate date: NSDate!) {
        self.dateFormatter.dateFormat = "yyyy.M"
        let currentMonth = dateFormatter.stringFromDate(date)
//        print(currentMonth)
        currentDateLabel.text = currentMonth
        currentDateLabel.sizeToFit()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}