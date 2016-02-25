//
//  CAProfileViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/2/14.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire
import MJExtension

class CAProfileViewController: UIViewController {
    var tableView:UITableView!
    var profileHeader:CAProfileHeader!
    var student:CAStudent!
    var titleArray:[String]!
    let subtitleArray:[String] = ["考生号", "学号", "生日", "身份证号", "专业编号", "专业名称", "所属班级", "入学年份"]
    let iconImageArray:[String] = ["profile_stu_test_no", "profile_stu_no", "profile_birthday", "profile_id_card", "profile_major_no", "profile_major_name", "profile_class", "profile_school_date"]
    private let profileCellIdentifier = "ProfileInfoCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "PROFILE"
        self.view.backgroundColor = UIColor.whiteColor()
        removeNavigationBarBorder()
        setupTableView()
        setupData()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        self.setupTitleArray()
//        self.setupHeaderLabel()
    }
    
    private func setupTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 66), style: .Plain)
        self.profileHeader = CAProfileHeader.instanceFromNib() as! CAProfileHeader
//        self.tableView.backgroundColor = kRGBA(74, g: 144, b: 226, a: 100)
        // 设置tableView的backgroundImage
        let backImageView = UIImageView.init(frame: self.tableView.frame)
        backImageView.image = UIImage(named: "profile_bg_image")
        self.tableView.backgroundView = backImageView
        
        self.tableView.tableHeaderView = profileHeader
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0)
        self.tableView!.registerNib(CAProfileInfoCell.nib(), forCellReuseIdentifier: profileCellIdentifier)
        self.view.addSubview(self.tableView)
    }
    
    private func removeNavigationBarBorder(){
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
    }
    
    private func setupData(){
        Alamofire.request(.GET, "http://202.118.31.241:8080/api/v1/schoolRoll?token=201602192328181600003301580").validate()
            .responseString{ response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data: NSData = value.dataUsingEncoding(NSUTF8StringEncoding)!
                        let json = NSData.NSDataToJSON(data)
                        let studentArray = json!["data"] as! [AnyObject]
                        let studentDictionary = studentArray[0] as! [String:AnyObject]
                        self.student = CAStudent.mj_objectWithKeyValues(studentDictionary) as CAStudent
                        CAStudentTool.saveStudent(self.student)
                        
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    private func setupTitleArray(){
        let student = CAStudentTool.student()
        self.titleArray = [student.examId, student.StudentId, student.birth, student.idCard, student.professionId, student.professionName, student.className, student.startDate]
        print(titleArray)
        self.tableView.reloadData()
    }
    
    private func setupHeaderLabel(){
        let student = CAStudentTool.student()
        self.profileHeader.englishNameLabel.text = student.englishName
        self.profileHeader.nameLabel.text = student.StudentName
    }
}

// MARK: - UITableView
extension CAProfileViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(profileCellIdentifier, forIndexPath: indexPath) as! CAProfileInfoCell
//        cell.titleLabel?.text = self.titleArray[indexPath.row]
        cell.subtitleLabel?.text = self.subtitleArray[indexPath.row]
        cell.iconImageView?.image = UIImage(named:String.init(format: "%@", self.iconImageArray[indexPath.row]))
        cell.contentView.backgroundColor = UIColor.whiteColor()
        return cell
    }
}
