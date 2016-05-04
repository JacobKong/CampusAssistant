//
//  CACheckGradesViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CACheckGradesViewController: UIViewController {
    var tableView:UITableView!
    let courseArray:[String] = ["课程1","课程2","课程3","课程4","课程5","课程6"]
    
    private let gradeCellIdentifier = "GradeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "查成绩"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        initTableView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initTableView(){
        self.tableView = UITableView.init(frame: kScreenBounds, style: .Plain)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView!.registerNib(CAGradeCell.nib(), forCellReuseIdentifier: gradeCellIdentifier)
        
        self.view.addSubview(tableView)
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

extension CACheckGradesViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(gradeCellIdentifier, forIndexPath: indexPath) as! CAGradeCell
        
        cell.titleLabel.text = self.courseArray[indexPath.row]
        
        return cell
    }
}