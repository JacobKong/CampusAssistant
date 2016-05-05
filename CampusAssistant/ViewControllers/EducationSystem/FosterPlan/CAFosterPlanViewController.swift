//
//  CAFosterPlanViewController.swift
//  CampusAssistant
//
//  Created by JacobKong on 16/3/1.
//  Copyright © 2016年 com.jacob. All rights reserved.
//

import UIKit

class CAFosterPlanViewController: UIViewController {
    var tableView:UITableView!
    var menuView: BTNavigationDropdownMenu!
    var fosterPlanHeader:CAFosterPlanHeader!
    private let fosterPlanCellIdentifier = "fosterPlanCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "培养计划"
        self.view.backgroundColor = UIColor.whiteColor()
        setupNavigationBarDropDownMenu()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        menuView.animationDuration = 0.1
        menuView.hide()
    }
    
    private func setupNavigationBarDropDownMenu(){
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks","Most Popular", "Latest", "Trending", "Nearest", "Top Picks", "Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, title: "请选择专业", items: items)
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

    private func setupTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 30), style: .Plain)
        self.fosterPlanHeader = CAFosterPlanHeader.instanceFromNib() as! CAFosterPlanHeader
        fosterPlanHeader.kindLabel.textColor = UIColor.caNavigationBarColor()
        self.tableView.tableHeaderView = fosterPlanHeader
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 60
        self.tableView.registerNib(CAFosterPlanCell.nib(), forCellReuseIdentifier: fosterPlanCellIdentifier)
        self.view.addSubview(self.tableView)
    }
}

extension CAFosterPlanViewController:UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(fosterPlanCellIdentifier, forIndexPath: indexPath) as! CAFosterPlanCell
        cell.courseNameLabel.textColor = UIColor.caNavigationBarColor()
        return cell
    }
}