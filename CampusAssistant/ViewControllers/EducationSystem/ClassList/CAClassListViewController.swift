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
    let currentDateLabel =  UILabel()
//    let currentDateButton = UIButton.init(type: UIButtonType.Custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
        setupDayPlannerView()
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
    
    override func dayPlannerView(view: MGCDayPlannerView!, willDisplayDate date: NSDate!) {
        self.dateFormatter.dateFormat = "yyyy.M"
        let currentMonth = dateFormatter.stringFromDate(date)
        print(currentMonth)
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