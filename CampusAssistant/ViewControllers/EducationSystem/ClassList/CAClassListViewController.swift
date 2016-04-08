//
//  CAClassListViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "看课表"
        self.view.backgroundColor = UIColor.whiteColor()
        setupDayPlannerView()
        self.calendar = NSCalendar.currentCalendar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupDayPlannerView(){
        self.dateFormatter.calendar = self.calendar
        self.dayPlannerView.backgroundColor = UIColor.whiteColor()
        self.dayPlannerView.backgroundView = UIView()
        self.dayPlannerView.backgroundView.backgroundColor = UIColor.whiteColor()
        self.dayPlannerView.numberOfVisibleDays = 7
        self.dayPlannerView.timeColumnWidth = 50
        self.dayPlannerView.hourRange = NSRange.init(location: 8, length: 14)
        
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
