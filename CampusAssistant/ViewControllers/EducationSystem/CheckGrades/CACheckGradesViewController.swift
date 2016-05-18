//
//  CACheckGradesViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire

class CACheckGradesViewController: UIViewController {
    var tableView: UITableView!
    var gpaLabel: UILabel!
    var courseArray: [[String]] = Array()
    var menuView: BTNavigationDropdownMenu!
    
    var termList:[[String]] = [["Most Popular"]]

    private let gradeCellIdentifier = "GradeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "查成绩"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.

        setupView()
        setupNavigationBarDropDownMenu()
        setupTermList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        menuView.animationDuration = 0.1
        menuView.hide()
    }

    private func setupView() {
        setupGPALabel()
        setupTableView()
        removeNavigationBarBorder()
    }

    private func setupGPALabel() {
//        let view = UIView.init(frame: CGRectMake(0, 0, kScreenWidth, 36))
//        view.backgroundColor = kRGBA(0, g: 122, b: 255, a: 1.0)

        self.gpaLabel = UILabel.init(frame: CGRectMake(0, 0, kScreenWidth, 30))
        self.gpaLabel.text = "目前绩点: 0.00"
        self.gpaLabel.textColor = kRGBA(255, g: 255, b: 255, a: 1.0)
        self.gpaLabel.backgroundColor = kRGBA(0, g: 122, b: 255, a: 1.0)
        self.gpaLabel.textAlignment = NSTextAlignment.Center
        self.gpaLabel.font = UIFont.boldSystemFontOfSize(13)

//        view.addSubview(gpaLabel)
//        self.view.addSubview(view)
        self.view.addSubview(gpaLabel)

//        let divider = UIView.init(frame: CGRectMake(0, 35, kScreenWidth, 1))
//        divider.backgroundColor = kRGBA(0, g: 0, b: 0, a: 0.4)
//        self.view.addSubview(divider)
    }

    private func setupTableView() {
        self.tableView = UITableView.init(frame: CGRectMake(0, 30, kScreenWidth, kScreenHeight - 30), style: .Plain)

        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.tableView!.registerNib(CAGradeCell.nib(), forCellReuseIdentifier: gradeCellIdentifier)

        self.view.addSubview(tableView)
    }

    private func removeNavigationBarBorder() {
        for parent in self.navigationController!.navigationBar.subviews {
            if (!(parent is UIButton)) {
                for childView in parent.subviews {
                    if (childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
        }
    }

    private func setupNavigationBarDropDownMenu() {
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "请选择学期", items: termList)
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = UIColor.caNavigationBarColor()
        menuView.cellSelectionColor = UIColor.caDarkerNavigationBarColor()
        menuView.cellTextLabelColor = UIColor.whiteColor()
        menuView.cellTextLabelFont = UIFont(name: "Montserrat-Regular", size: 17)
        menuView.cellTextLabelAlignment = .Left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.blackColor()
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {
            (indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            //            self.selectedCellLabel.text = items[indexPath]
            self.menuView.setMenuTitle(self.termList[indexPath][1])
            
            let para: [String:AnyObject] = [
                "YearTermNO": self.termList[indexPath][0]
            ]
            
            Alamofire.request(.POST, "http://202.118.31.197/ACTIONQUERYSTUDENTSCORE.APPPROCESS", parameters: para).validate().responseString {
                (response) in
                switch response.result {
                case .Success:
                    var r_result: [[String]] = CARegexTool.parseGradeTable(response.result.value!)
                    
                    self.courseArray.removeAll()
                    
                    self.gpaLabel.text = "目前绩点: \(r_result[0][0])"
                    
                    for i in 0 ..< r_result.count-1 {
                        self.courseArray.append(Array())
                        self.courseArray[i].append(r_result[i+1][2])
                        self.courseArray[i].append(r_result[i+1][7])
                        self.courseArray[i].append(r_result[i+1][8])
                        self.courseArray[i].append(r_result[i+1][9])
                        self.courseArray[i].append(r_result[i+1][10])
                    }
                    
                    self.tableView.reloadData()
                    
                    print(r_result)
                case .Failure(let error):
                    print(error)
                }
                
            }
        }

        self.navigationItem.titleView = menuView
    }

    private func setupTermList() {
//        print("Setup Data")
//        Alamofire.request(.GET, "http://202.118.31.241:8080/api/v1/termList?token=201602192328181600003301580").validate()
//        .responseString {
//            response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    let data: NSData = value.dataUsingEncoding(NSUTF8StringEncoding)!
//                    let json = NSData.NSDataToJSON(data)
//                    let termData = json!["data"] as! [AnyObject]
////                    print(termData!["termName"] as! [String:AnyObject])
////                    let studentDictionary = studentArray[0] as! [String:AnyObject]
////                    let student = CAStudent.mj_objectWithKeyValues(studentDictionary) as CAStudent
////                    CAStudentTool.saveStudent(self.student)
//                }
//            case .Failure(let error):
//                print(error)
//            }
//        }
        
        CANetworkTool.setAAOCookies("X7WZPtqSvgAnzEzwcnjKOUNDtytBK2bHlhcsVWfNhplMU2v3N0Aq!1269920556")
        
        Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYSTUDENTSCORE.APPPROCESS").validate().responseString {
            (response) in
            switch response.result {
            case .Success:
                let r_result: [[String]] = CARegexTool.parseGradeTermList(response.result.value!)
                self.termList.removeAll()
                self.menuView.tableView.items.removeAll()
                for result in r_result{
                    self.termList.append(result)
                    self.menuView.tableView.items.append(result[1])
                }
                self.menuView.tableView.reloadData()
                print(r_result)
                self.menuView.tableView.tableView(self.menuView.tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: self.termList.count - 1, inSection: 0))
            case .Failure(let error):
                print(error)
            }
            
        }
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

extension CACheckGradesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(gradeCellIdentifier, forIndexPath: indexPath) as! CAGradeCell

        cell.titleLabel.text = self.courseArray[indexPath.row][0]
        cell.detailLabel.text = "平时: \(self.courseArray[indexPath.row][1]) 期中: \(self.courseArray[indexPath.row][2]) 期末: \(self.courseArray[indexPath.row][3])"
        cell.scoreLabel.text = self.courseArray[indexPath.row][4]

        return cell
    }
}