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
        
//         测试 IP网关
//        testIPGW()
        
        
        CACalendarTool.getTodayNextEvent { (event) in
            if (event) != nil {
                if NSDate().compare(event!.startDate).rawValue > 0 {
                    print("正在上课")
                    print(event?.title)
                }else{
                    print("下一节课")
                    print(event?.title)
                }
            }else{
                print("今天没有课了")
            }
        }
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
    
    private func testIPGW(){
        Alamofire.request(.GET, "http://ipgw.neu.edu.cn/ac_detect.php?ac_id=1&").responseString {
            (response) in
            switch response.result {
            case .Success:
                //                var r_result: [[String]] = CARegexTool.parseCreditTable(response.result.value!)
                print(response.response)
                print(response.result.value as String!)
                print(response.response?.URL)              // 此项需要首先获取以获得正确请求地址
                
                // 登录
                let par: [String:AnyObject] = [
                    "action":"login",
                    "ac_id":"1",
                    "user_ip":"",
                    "nas_ip":"",
                    "user_mac":"",
                    "url":"",
                    "username":"20134649",                  // 学号
                    "password":"950426",                    // 密码 此两项需要保存
                    "save_me":"0"
                ]
                
                let url = response.response?.URL?.absoluteString

                Alamofire.request(.POST, url!, parameters: par).validate().responseString {
                    (response) in
                    switch response.result {
                    case .Success:
                        print(response.result.value as String!)
                        
                        // 此处需要判断是否成功登录 若失败的话使用
                        // CARegexTool.parseGateWayErrorResult(response.result.value!)
                        // 来取出错误原因
                        
                        let ip = CARegexTool.parseGateWayIP(response.result.value!)     // IP地址 此项需要存储
                        
                        //注销
                        
                        let para: [String:AnyObject] = [
                            "action":"auto_logout",
                            "info":"",
                            "user_ip":ip                    // 在此处填入ip
                        ]
                        
                        Alamofire.request(.POST, url!, parameters: para).validate().responseString {
                            (response) in
                            switch response.result {
                            case .Success:
                                print(response.result.value as String!)
                            case .Failure(let error):
                                print(error)
                            }
                            
                        }

                    case .Failure(let error):
                        print(error)
                    }
                    
                }
            case .Failure(let error):
                print(error)
            }

        }
    }

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