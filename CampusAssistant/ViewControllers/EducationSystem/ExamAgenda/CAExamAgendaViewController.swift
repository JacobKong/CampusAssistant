//
//  CAExamAgendaViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire

class CAExamAgendaViewController: UIViewController {
    var tableView:UITableView!
    var examList:[[String]] = Array()
    
    private let examCellIdentifier = "ExamCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "考试日程"
        self.view.backgroundColor = UIColor.whiteColor()
//        let tableView = UITableView.init(frame: self.view.bounds, style: .Plain)
        // Do any additional setup after loading the view.
        
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView(){
        setupTableView()
        setupExamList()
    }
    
    private func setupTableView(){
        self.tableView = UITableView.init(frame: kScreenBounds, style: .Plain)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView!.registerNib(CAExamCell.nib(), forCellReuseIdentifier: examCellIdentifier)
        
        self.view.addSubview(tableView)
    }
    
    private func setupExamList(){
        CANetworkTool.setAAOCookies("X7C2EqWL5vvrQVodOUuM2IBSdjywGr9beZ9uqypeEjQNd02rUDDL!1269920556")
        
        Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYEXAMTIMETABLEBYSTUDENT.APPPROCESS?mode=2").validate().responseString {
            (response) in
            switch response.result {
            case .Success:
                let r_result: [[String]] = CARegexTool.parseExamTable(response.result.value!)
                self.examList.removeAll()
                for result in r_result{
                    self.examList.append(result)
                }
                self.tableView.reloadData()
                print(r_result)
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

extension CAExamAgendaViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.examList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(examCellIdentifier, forIndexPath: indexPath) as! CAExamCell
        
        cell.titleLabel.text = self.examList[indexPath.row][1]
        cell.infoLabel.text = "\(self.examList[indexPath.row][3]) \(self.examList[indexPath.row][5])"
        
        var today = NSDate(),target:NSDate
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd";
        formatter.locale = NSLocale(localeIdentifier:"zh_CN");
        today = formatter.dateFromString(formatter.stringFromDate(today))!
        
        if(self.examList[indexPath.row][3]==""){
            cell.countdownLabel.text = "??天"
        }else{
            let str = NSString(string: self.examList[indexPath.row][3])
            target = formatter.dateFromString(str.substringToIndex(10))!
            
            if(today.compare(target).rawValue>0){
                cell.countdownLabel.text = "过"
            }else{
                cell.countdownLabel.text = "\(NSInteger(target.timeIntervalSinceNow) / 3600 / 24)天"
            }
        }
        
        return cell
    }
}
