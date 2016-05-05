//
//  CACreditWarningViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CACreditWarningViewController: UIViewController {
    var tableView:UITableView!
    private let creditWarningCellIdentifier = "CreditCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "学分预警"
        self.view.backgroundColor = UIColor.whiteColor()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 30), style: .Plain)
        
        //        self.tableView.backgroundColor = kRGBA(74, g: 144, b: 226, a: 100)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 58, 0, 0)
        self.tableView.rowHeight = 82
        self.tableView!.registerNib(CACreditCell.nib(), forCellReuseIdentifier: creditWarningCellIdentifier)
        self.view.addSubview(self.tableView)
    }
    
}

extension CACreditWarningViewController:UITableViewDelegate, UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(creditWarningCellIdentifier, forIndexPath: indexPath) as! CACreditCell
        cell.courseGroupLabel.textColor = UIColor.caNavigationBarColor()
        return cell
    }
}
