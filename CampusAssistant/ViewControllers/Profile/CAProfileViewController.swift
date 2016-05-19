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
import SVProgressHUD

class CAProfileViewController: UIViewController {
    var tableView:UITableView!
    var profileHeader:CAProfileHeader!
    var student:CAStudent!
    var titleArray:[String]!
    let subtitleArray:[String] = ["学号", "专业名称", "所属班级", "培养层次", "入学年份"]
    let iconImageArray:[String] = ["profile_stu_no", "profile_major_name", "profile_class", "profile_major_no", "profile_school_date"]
    private let profileCellIdentifier = "ProfileInfoCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "PROFILE"
        self.view.backgroundColor = UIColor.whiteColor()
        self.titleArray = ["", "", "", "", ""]
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
        let bgView = UIView.init(frame: self.tableView.frame)
        bgView.backgroundColor = UIColor.whiteColor()
        let bgColorView = UIView.init(frame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.5))
        bgColorView.backgroundColor = UIColor.caNavigationBarColor()
        bgView.addSubview(bgColorView)
        self.tableView.backgroundView = bgView
        
        self.tableView.tableHeaderView = profileHeader
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0)
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
        Alamofire.request(.GET,"http://202.118.31.197/ACTIONDSPUSERPHOTO.APPPROCESS").responseData { (response) in
            switch response.result {
            case .Success:
                let image = UIImage(data: response.data! as NSData)
                self.profileHeader.iconImageView.image = image
                break
            case .Failure(let error):
                print(error)
                SVProgressHUD.showErrorMessage(kErrorMessage)
                break
            }
            
        }
        
        if !CAStudentTool.isExistStudentData() {
            Alamofire.request(.GET, "http://202.118.31.197/ACTIONFINDSTUDENTINFO.APPPROCESS?mode=1&showMsg=").validate().responseString {
                (response) in
                //["20132037", "孔伟杰", "男", "软件学院", "2013", "软件工程", "2013级", "软件1302", "全日制本科"]
                switch response.result {
                case .Success:
                    var r_result: [String] = CARegexTool.parsePersonalInfoTable(response.result.value!)
                    self.student = CAStudent()
                    self.student.StudentId = r_result[0]
                    self.student.StudentName = r_result[1]
                    self.student.englishName = self.getPingYinLetter(r_result[1])
                    self.student.sex = r_result[2]
                    self.student.collegeName = r_result[3]
                    self.student.startDate = r_result[4]
                    self.student.professionName = r_result[5]
                    self.student.className = r_result[7]
                    self.student.StudyForm = r_result[8]
                    CAStudentTool.saveStudent(self.student)
                    self.titleArray[0] = self.student.StudentId
                    self.titleArray[1] = self.student.collegeName
                    self.titleArray[2] = self.student.professionName
                    self.titleArray[3] = self.student.StudyForm
                    self.titleArray[4] = self.student.startDate
                    self.profileHeader.nameLabel.text = "\(self.student.StudentName)  \(self.student.sex)"
                    self.profileHeader.englishNameLabel.text = self.student.englishName
                    print(r_result)
                    self.tableView.reloadData()
                case .Failure(let error):
                    SVProgressHUD.showErrorMessage(kErrorMessage)
                    print(error)
                }
            }
        }else{
            self.student = CAStudentTool.student()
            setupTitleArray()
            self.profileHeader.nameLabel.text = "\(self.student.StudentName)  \(self.student.sex)"
            self.profileHeader.englishNameLabel.text = self.student.englishName
        }
    }
    
    func getPingYinLetter(str: String)-> String{
        //转换成可变数据
        let mutableUserAgent = NSMutableString(string: str) as CFMutableString
        //取得带音调拼音
        if CFStringTransform(mutableUserAgent, nil,kCFStringTransformMandarinLatin, false){
            //取得不带音调拼音
            if CFStringTransform(mutableUserAgent,nil,kCFStringTransformStripDiacritics,false){
                let str1 = mutableUserAgent as String
//                let s = str1.capitalizedString.subString(0, endOffset: -str1.length+1)
                return str1.capitalizedString
            }else{
                return str
            }
        }else{
            return str
        }
    }
    
    private func setupTitleArray(){
        self.titleArray[0] = self.student.StudentId
        self.titleArray[1] = self.student.collegeName
        self.titleArray[2] = self.student.professionName
        self.titleArray[3] = self.student.StudyForm
        self.titleArray[4] = self.student.startDate
        
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
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(profileCellIdentifier, forIndexPath: indexPath) as! CAProfileInfoCell
        cell.titleLabel?.text = self.titleArray[indexPath.row]
        cell.subtitleLabel?.text = self.subtitleArray[indexPath.row]
        cell.iconImageView?.image = UIImage(named:String.init(format: "%@", self.iconImageArray[indexPath.row]))
        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        return cell
    }
}
