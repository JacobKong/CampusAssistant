//
//  CAWeekViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/4/8.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
//Protocol CalendarViewControllerDelegate
//@objc protocol WeekViewControllerDelegate: MGCDayPlannerEKViewControllerDelegate, CalendarViewControllerDelegate, UIViewControllerTransitioningDelegate{
//}

class CAWeekViewController: MGCDayPlannerEKViewController {
//    var delegate:WeekViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dayPlannerView.backgroundColor = UIColor.clearColor()
        self.dayPlannerView.backgroundView = UIView()
        self.dayPlannerView.backgroundView.backgroundColor = UIColor.whiteColor()
        self.dayPlannerView.dayHeaderHeight = 50
        // Do any additional setup after loading the view.
    }
}

// MARK: - MGCDayPlannerViewController
extension CAWeekViewController{
    override func dayPlannerView(view: MGCDayPlannerView!, canCreateNewEventOfType type: MGCEventType, atDate date: NSDate!) -> Bool {
        
        let comps = self.calendar.components(.Weekday, fromDate: date) 
        return comps.weekday != 1;
    }
    
    override func dayPlannerView(view: MGCDayPlannerView!, didScroll scrollType: MGCDayPlannerScrollType) {
//        let date = view.dateAtPoint(view.center, rounded: true)
//        if date != nil && (self.delegate.respondsToSelector(Selector("calendarViewController:didShowDate:"))){
//            self.delegate.calendarViewController
//        }
    }
}
// MARK: - CalendarControllerNavigation
extension CAWeatherSectionView{
}