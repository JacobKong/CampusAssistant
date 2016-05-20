//
//  CACreditWarningViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit
import Alamofire

class CACreditWarningViewController: UIViewController {
    var tableView:UITableView!
    private let creditWarningCellIdentifier = "CreditCell"
    var creditList:[[String]] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "学分预警"
        self.view.backgroundColor = UIColor.whiteColor()
        setupTableView()
        setupCreditData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64), style: .Plain)
        
        //        self.tableView.backgroundColor = kRGBA(74, g: 144, b: 226, a: 100)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 82
        self.tableView!.registerNib(CACreditCell.nib(), forCellReuseIdentifier: creditWarningCellIdentifier)
        self.view.addSubview(self.tableView)
    }
    
    private func setupCreditData(){
        Alamofire.request(.GET, "http://202.118.31.197/ACTIONQUERYBASESTUDENTINFO.APPPROCESS?mode=3").validate().responseString {
            (response) in
            switch response.result {
            case .Success:
                let r_result: [[String]] = CARegexTool.parseCreditTable(response.result.value!)
                self.creditList.removeAll()
                for result in r_result{
                    self.creditList.append(result)
                }
                self.tableView.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
    }
}

extension CACreditWarningViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.creditList.count > 0){
            return self.creditList.count - 1
        }
        return self.creditList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(creditWarningCellIdentifier, forIndexPath: indexPath) as! CACreditCell
        cell.courseGroupLabel.textColor = UIColor.caNavigationBarColor()
        cell.courseGroupLabel.text = self.creditList[indexPath.row][1]
        cell.information1Label.text = "计划学分: \(self.creditList[indexPath.row][2]) 已修学分: \(self.creditList[indexPath.row][3]) 学分差: \(self.creditList[indexPath.row][4])"
        cell.information2Label.text = "不及格学分和: \(self.creditList[indexPath.row][5])"
        return cell
    }
}
