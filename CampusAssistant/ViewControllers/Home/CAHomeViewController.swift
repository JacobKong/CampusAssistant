//
//  CAHomeViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Spring
import Alamofire
import SVProgressHUD
import SwiftyJSON

class CAHomeViewController: UIViewController {
    var isOpen = false
    var input: UITextField!
    var weatherView: CAWeatherSectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupScrollerView()
        setupWeatherSection()
        setupStudyLifeSection()
        setupAddMoreSection()
        setupRevealController()
        setupWeedNoTextview()
//        self.title = "NEU CAMPUS ASSISTANT"
//        self.title = "NEU Campus Assistant"

        // 测试 添加登录功能
//        setupTestLogin()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 设置navigationBar
    private func setupNavigationBar() {
        self.title = "NEU"
        let rightBarBtn = DesignableButton()
        rightBarBtn.setImage(UIImage(named: "navigationbar_side_menu"), forState: .Normal)
        rightBarBtn.frame = CGRectMake(0, 0, 22, 22)
        rightBarBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), forControlEvents: .TouchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = rightBarBtn
        self.revealViewController().delegate = self
        self.navigationItem.rightBarButtonItem = rightBarButton
//        let backItem = UIBarButtonItem.init(title: "", style: .Plain, target: nil, action: nil)
//        self.navigationItem.backBarButtonItem = backItem
    }

    private func setupScrollerView() {
        let scrollView = UIScrollView.init(frame: kScreenBounds)
        self.view = scrollView
        scrollView.contentSize = CGSize(width: kScreenWidth, height: kScreenHeight + 20)
        scrollView.scrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.whiteColor()
    }

    private func setupWeatherSection() {
        weatherView = CAWeatherSectionView.instanceFromNib() as! CAWeatherSectionView
        weatherView.frame = CGRectMake(0, 0, kScreenWidth, 220)
        self.view.addSubview(weatherView)
        self.obtainCurrentWeatherInfo()
        self.obtainDaliyWeather()
    }

    private func setupStudyLifeSection() {
        let view = CAStudyLifeSectionView.instanceFromNib() as! CAStudyLifeSectionView
        view.frame = CGRectMake(0, 220, kScreenWidth, 230)
        self.view.addSubview(view)
        view.delegate = self
    }

    private func setupAddMoreSection() {
        let view: UIView = CAAddMoreSectionView.instanceFromNib()
        view.frame = CGRectMake(0, 450, kScreenWidth, 50)
        self.view.addSubview(view)
    }

    private func setupRevealController() {
        let revealController: SWRevealViewController = self.revealViewController()
        self.view.addGestureRecognizer(revealController.panGestureRecognizer())
        revealController.rightViewRevealWidth = kScreenWidth - 60
    }

    private func obtainCurrentWeatherInfo(){
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/weather?id=2034937&units=metric&APPID=66e616f33710e6af3c0f25b185001dde").validate().responseJSON { (response) in
            switch response.result {
            case .Success:
                let json = JSON(response.result.value!)
                let main = json["main"]
                let temp = main["temp"].intValue
                let humidity = main["humidity"].stringValue
                let pressure = main["pressure"].stringValue
                self.weatherView.currentTempLabel.text = "\(temp)"
                self.weatherView.pressureLabel.text = "湿度: \(humidity)% 压力: \(pressure) hpa"
                
                let icon = json["weather"][0]["icon"].stringValue
                self.weatherView.currentWeatherImage.image = UIImage.init(named:  "weather_\(icon)")
                break
            case .Failure(let error):
                print(error)
                SVProgressHUD.showErrorMessage(kErrorMessage)
                break;
            }
        }
    }
    
    private func obtainDaliyWeather(){
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/forecast/daily?id=2034937&cnt=3&units=metric&APPID=66e616f33710e6af3c0f25b185001dde").validate().responseJSON { (response) in
            switch response.result {
            case .Success:
                let json = JSON(response.result.value!)
                let weatherArray = json["list"]
                for i in 0 ..< weatherArray.count{
                    let jsonObject = weatherArray[i]
                    let tempObject = jsonObject["temp"]
                    let minTemp = tempObject["min"].intValue
                    let maxTemp = tempObject["max"].intValue
                    let weatherObject = jsonObject["weather"][0]
                    let icon = weatherObject["icon"].stringValue
                    self.weatherView.setupTemperature(i, min: minTemp, max: maxTemp)
                    self.weatherView.setupWeatherIcon(i, iconName: icon)
                }
                break
            case .Failure(let error):
                print(error)
                SVProgressHUD.showErrorMessage(kErrorMessage)
                break;
            }
        }
    }
    
    private func setupWeedNoTextview(){
        let todayDate = NSDate()
        let todayNo = todayDate.dayOfWeek()
        self.weatherView.setupWeedNoTextview(todayNo)
        
    }
    // 测试 登录功能
    private func setupTestLogin() {
        let view: UIImageView = UIImageView.init(frame: CGRectMake(0, 500, kScreenWidth / 2, 40))
        input = UITextField.init(frame: CGRectMake(kScreenWidth / 2, 500, kScreenWidth / 2, 40))

//        self.hideKeyboardWhenTappedAround()

        self.view.addSubview(view)
        self.view.addSubview(input)

        if let url = NSURL(string: "http://202.118.31.197/ACTIONVALIDATERANDOMPICTURE.APPPROCESS") {
            if let data = NSData(contentsOfURL: url) {
                view.image = UIImage(data: data)
            }
        }
    }

    
    private func testLogin() {
        let paras: [String:AnyObject] = [
                "WebUserNO": "20134649",
                "Password": "950426",
                "Agnomen": input.text!
        ]

        Alamofire.request(.POST, "http://202.118.31.197/ACTIONLOGON.APPPROCESS?mode=4", parameters: paras).validate().responseString {
            (response) in
            switch response.result {
            case .Success:

                // 课程表
//                Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYSTUDENTSCHEDULEBYSELF.APPPROCESS").validate().responseString {
//                    (response) in
//                    switch response.result {
//                    case .Success:
//                        var r_result: [[String]] = CARegexTool.parseCourseTable(response.result.value!)
//                        print("\n")
//                    case .Failure(let error):
//                        print(error)
//                    }
//
//                }

                // 成绩

                let para: [String:AnyObject] = [
                    "YearTermNO": "13"                   // todo 以后改为先用GET获取学期列表
                ]

                Alamofire.request(.POST, "http://202.118.31.197/ACTIONQUERYSTUDENTSCORE.APPPROCESS", parameters: para).validate().responseString {
                    (response) in
                    switch response.result {
                    case .Success:
                        var r_result: [[String]] = CARegexTool.parseGradeTermList(response.result.value!)
                        r_result = CARegexTool.parseGradeTable(response.result.value!)

                        print(r_result)
                    case .Failure(let error):
                        print(error)
                    }

                }

                // 考试日程

//                Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYEXAMTIMETABLEBYSTUDENT.APPPROCESS?mode=2").validate().responseString {
//                    (response) in
//                    switch response.result {
//                    case .Success:
//                        var r_result: [[String]] = CARegexTool.parseExamTable(response.result.value!)
//                        print("\n")
//                    case .Failure(let error):
//                        print(error)
//                    }
//
//                }

//                 学业预警
//
//                Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYBASESTUDENTINFO.APPPROCESS?mode=3").validate().responseString {
//                    (response) in
//                    switch response.result {
//                    case .Success:
//                        var r_result: [[String]] = CARegexTool.parseCreditTable(response.result.value!)
//                        print("\n")
//                    case .Failure(let error):
//                        print(error)
//                    }
//
//                }

                // 空闲教室

//                let para: [String:AnyObject] = [
//                    "YearTermNO": "14",                   // todo 以后改为先用GET获取学期列表
//                    "WeekdayID":"1",
//                    "StartSection":、"1",
//                    "EndSection":"12",
//                    "ClassroomNO":"000107101"             // todo 选定教学楼后获取教室列表
//                ]
//
//                Alamofire.request(.POST, "http://202.118.31.197/ACTIONQUERYCLASSROOMUSEBYWEEKDAYSECTION.APPPROCESS?mode=2", parameters: para).validate().responseString {
//                    (response) in
//                    switch response.result {
//                    case .Success:
//                        var r_result: [[String]] = CARegexTool.parseEmptyClassroomTable(response.result.value!)
//                        print("\n")
//                    case .Failure(let error):
//                        print(error)
//                    }
//
//                }

                // 空闲教室相关参数变量获取

//                let par: [String:AnyObject] = [
//                    "YearTermNO": "14",                   // todo 以后改为先用GET获取学期列表
//                    "WeekdayID":"1",
//                    "StartSection":"1",
//                    "EndSection":"12",
//                    "STORYNO":"0001",                     // todo 选定教室刷新
//                    "ClassroomNO":"000107101"             // todo 选定教学楼后获取教室列表
//                ]
//
//                Alamofire.request(.POST, "http://202.118.31.197/ACTIONQUERYCLASSROOMNOUSE.APPPROCESS", parameters: par).validate().responseString {
//                    (response) in
//                    switch response.result {
//                    case .Success:
//                        var r_result: [[String]] = CARegexTool.parseEptClsrmClsrmList(response.result.value!)
////                        r_result = CARegexTool.parseEptClsrmStoryList(response.result.value!)
////                        r_result = CARegexTool.parseEptClsrmTermList(response.result.value!)
//                        print("\n")
//                    case .Failure(let error):
//                        print(error)
//                    }
//
//                }

                // 个人信息

//                Alamofire.request(.GET, "http://202.118.31.197/ACTIONFINDSTUDENTINFO.APPPROCESS?mode=1&showMsg=").validate().responseString {
//                    (response) in
//                    switch response.result {
//                    case .Success:
//                        var r_result: [String] = CARegexTool.parsePersonalInfoTable(response.result.value!)
//                        print("\n")
//                    case .Failure(let error):
//                        print(error)
//                    }
//
//                }
            case .Failure(let error):
                print(error)
            }
        }
    }

    // 此处设定了弹出键盘时点击别处收起键盘

//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
//    }
//
//    func dismissKeyboard() {
//        view.endEditing(true)
//
//        // 改成按钮
//        testLogin()
//    }

}

extension CAHomeViewController: SWRevealViewControllerDelegate {
    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
        let rightBarItemButton = self.navigationItem.rightBarButtonItem?.customView as! DesignableButton

        if position == FrontViewPosition.Left {
            // 关闭
            rightBarItemButton.animation = "morph"
            rightBarItemButton.curve = "linear"
            rightBarItemButton.duration = 0.5
            rightBarItemButton.setImage(UIImage(named: "navigationbar_side_menu"), forState: .Normal)
            print("Left")
        } else if position == FrontViewPosition.LeftSide {
            // 开启
            rightBarItemButton.animation = "morph"
            rightBarItemButton.curve = "linear"
            rightBarItemButton.duration = 0.5
            rightBarItemButton.setImage(UIImage(named: "navigationbar_cancle"), forState: .Normal)
            print("LeftSide")
        }
        rightBarItemButton.animate()
    }

}

extension CAHomeViewController: StudyLifeSectionProtocol {
    func classListButoonDidPressed() {
        let classListVc = CAClassListViewController()
        self.navigationController?.pushViewController(classListVc, animated: true)
    }

    func emptyRoomButtonDidPressed() {
        let emptyRoomVc = CAEmptyRoomViewController()
        self.navigationController?.pushViewController(emptyRoomVc, animated: true)
    }

    func checkGradeButtonDidPressed() {
        let chechGradeVc = CACheckGradesViewController()
        self.navigationController?.pushViewController(chechGradeVc, animated: true)
    }

    func examAgendaButtonDidPressed() {
        let examAgendaVc = CAExamAgendaViewController()
        self.navigationController?.pushViewController(examAgendaVc, animated: true)
    }
}