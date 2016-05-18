//
//  CAExamAgendaViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAExamAgendaViewController: UIViewController {
    var tableView:UITableView!
    let examArray:[String] = ["考试1","考试2","考试3","考试4","考试5","考试6"]
    
    private let examCellIdentifier = "ExamCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "考试日程"
        self.view.backgroundColor = UIColor.whiteColor()
//        let tableView = UITableView.init(frame: self.view.bounds, style: .Plain)
        // Do any additional setup after loading the view.
        
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initView(){
        initTableView()
    }
    
    private func initTableView(){
        self.tableView = UITableView.init(frame: kScreenBounds, style: .Plain)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView!.registerNib(CAExamCell.nib(), forCellReuseIdentifier: examCellIdentifier)
        
        self.view.addSubview(tableView)
    }
    
    

}

extension CAExamAgendaViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(examCellIdentifier, forIndexPath: indexPath) as! CAExamCell
        
        cell.titleLabel.text = self.examArray[indexPath.row]
        
        return cell
    }
}
