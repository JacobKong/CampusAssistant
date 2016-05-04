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
    var menuView: BTNavigationDropdownMenu!

    let courseArray:[String] = ["课程1","课程2","课程3","课程4","课程5","课程6"]
    
    private let gradeCellIdentifier = "GradeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "查成绩"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        setupTableView();
        setupNavigationBarDropDownMenu();
    }
    
    override func viewWillDisappear(animated: Bool) {
        menuView.animationDuration = 0.1
        menuView.hide()
    }
    
    private func setupTableView(){
        self.tableView = UITableView.init(frame: kScreenBounds, style: .Plain)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView!.registerNib(CAGradeCell.nib(), forCellReuseIdentifier: gradeCellIdentifier)
        
        self.view.addSubview(tableView)
    }
    
    private func setupNavigationBarDropDownMenu(){
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks","Most Popular", "Latest", "Trending", "Nearest", "Top Picks", "Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "请选择学期", items: items)
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
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            //            self.selectedCellLabel.text = items[indexPath]
        }
        
        self.navigationItem.titleView = menuView
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