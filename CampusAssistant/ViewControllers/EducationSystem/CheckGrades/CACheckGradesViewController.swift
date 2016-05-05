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
    var gpaLabel:UILabel!
    let courseArray:[String] = ["课程1","课程2","课程3","课程4","课程5","课程6"]
    var menuView: BTNavigationDropdownMenu!
    
    private let gradeCellIdentifier = "GradeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "查成绩"
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        
        initView()
        setupNavigationBarDropDownMenu();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        menuView.animationDuration = 0.1
        menuView.hide()
    }

    private func initView(){
        initGPALabel()
        initTableView()
        removeNavigationBarBorder()
    }
    
    private func initGPALabel(){
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
    
    private func initTableView(){
        self.tableView = UITableView.init(frame: CGRectMake(0, 30, kScreenWidth, kScreenHeight - 30), style: .Plain)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView!.registerNib(CAGradeCell.nib(), forCellReuseIdentifier: gradeCellIdentifier)
        
        self.view.addSubview(tableView)
    }
    
    private func removeNavigationBarBorder(){
        for parent in self.navigationController!.navigationBar.subviews {
            if (!(parent is UIButton)){
                for childView in parent.subviews {
                    if(childView is UIImageView) {
                        childView.removeFromSuperview()
                    }
                }
            }
        }
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